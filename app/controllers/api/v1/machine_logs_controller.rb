class Api::V1::MachineLogsController < Api::V1::BaseController
  #before_filter :authorize_admin!, :except => [:index, :show]
  #before_filter :find_machine, :only => [:show, :update, :destroy]
  #
  #def index
  #  @machines = MachineLog.all
  #  respond_with(@machines)
  #end
  #
  #def show
  #  respond_with @machine
  #end
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

  #def update
  #  @machine.update_attributes(params[:machine])
  #  respond_with(@machine)
  #end
  #
  #def destroy
  #  @machine.destroy
  #  respond_with(@machine)
  #end
  #
  #private
  #
  #def find_machine
  #  @machine = Machine.find(params[:id])
  #rescue ActiveRecord::RecordNotFound
  #  error = { :error => "The machine you were looking for could not be found."}
  #  respond_with(error, :status => 404)
  #end

end