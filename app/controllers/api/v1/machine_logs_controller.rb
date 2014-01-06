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
#  {"created_at":"2013-12-26T07:43:51Z","description":"testing ","id":1,"machine_id":null,"updated_at":"2013-12-26T07:43:51Z"}
  def create
    @machine = Machine.where(:serial_number => params[:serial_id]).first
    if @machine.nil?
      render json:{:status => false, :message => "please provide valid serial id" }
    else
      machine_log = MachineLog.new(:machine_id => @machine.id, :description => params[:data])
      if machine_log.save!
        render json:{:status => true}
      else
        render json:{:status => false, :message => @machine.errors.full_messages }
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