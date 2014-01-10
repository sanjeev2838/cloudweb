class Api::V1::MachineLogsController < Api::V1::BaseController

  def create
    @machine = Machine.where(:serialid => params[:serialid]).first
    if @machine.nil?
      render json:{:status => false, :message => "please provide valid serialid " }
    else
      @machine_log = MachineLog.create(:machine_id => @machine.id, :data => params[:data])
      if @machine_log.valid?
        render json:{:status => true}
      else
        render json:{:status => false, :message => @machine_log.errors.full_messages }
      end
    end
  end

end