class Api::V1::MachineLogsController < Api::V1::BaseController

  def create
    #message=["TIMEOUT_TEMP","LIMIT_CLEAN_NUMBER","LIMIT_CLEAN_TIME","TEMP_CLEAN","DELAY_TEMP_CLEAN","WATER_CLEAN_TIME"]
    #mess = []
    #2.times do |i|
    #  mess << message.sample
    #end
    @machine = Machine.where(:serialid => params[:serialid]).first
    @parent_profile = ParentProfile.find_all_by_machine_id(@machine.id)
    if @machine.nil?
      render json:{:status => false, :message => "please provide valid serialid " }
    else
      @machine_log = MachineLog.create(:machine_id => @machine.id, :data => params[:data])
      if @machine_log.valid?
        @parent_profile.each do |parent|
        if parent.devicetypeid==0
            #MachineLog.iphone_notifications(parent.tokenid,mess)
        else parent.devicetypeid==1
            #MachineLog.android_notifications(parent.tokenid,mess)
        end
        end

        render json:{:status => true}
      else
        render json:{:status => false, :message => @machine_log.errors.full_messages }
      end
    end
  end

end