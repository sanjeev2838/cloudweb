# http://d1.diluo.nu/api/v2/logs
#
# With POST JSON data
#
# {
#  "01":<serial>,
#  "64": <data  - integer byte>
# }


class Api::V2::MachineLogsController < Api::Default::BaseController

  def create
    string  = (params[:data]).gsub('%2C', ',') if params[:data]
    log_params  = JSON.parse(string)
    logger.debug "New Log entry: #{log_params}"
    serial_id = log_params["01"]
    data = log_params["64"]
    @machine = Machine.where(:serialid => serial_id).first
    if @machine.nil?
      render json:{:status => false, :message => "please provide valid serialid " }
    else
      @profiles = ParentProfile.find_all_by_machine_id(@machine.id)
      @machine_log = MachineLog.new(:machine_id => @machine.id, :data => data )
      if @machine_log.save
        @profiles.each do |parent|
          I18n.locale = parent.lang.to_sym
          data=I18n.t(@machine_log.log_type)
          if parent.devicetypeid == 0
              MachineLog.iphone_notifications(parent.tokenid,data) if parent.tokenid
          elsif parent.devicetypeid == 1
              MachineLog.android_notifications(parent.tokenid,data) if parent.tokenid
          end
          I18n.locale = :en
        end
        render json:{:status => true}
      else
        render json:{:status => false, :message => @machine_log.errors.full_messages }
      end
    end
  end

end

