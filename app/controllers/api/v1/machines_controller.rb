class Api::V1::MachinesController < Api::V1::BaseController
 #before_filter :authorize_admin!, :except => [:index, :show]
 # before_filter :find_machine, :only => [:show, :update, :destroy]

  #def index
  #  @machines = Machine.all
  #  respond_with(@machines)
  #end
  #
  #def show
  #  respond_with @machine
  #end

  #url to test it

  #curl -X POST -H "Content-type: application/json" -d '{"activated_on":"2013-12-23T00:00:00Z","bootloader_version":"2r2r32r23","created_at":"2013-12-24T11:57:08Z","firmware_version":"222323","hw_config":"2r32r322","id":2,"ip_address":"10.0.5.29","mac_address":"00:09:6B:DF:FE:42","serial_number":324242141,"status":true,"updated_at":"2013-12-24T11:57:08Z"}'  http://localhost:3000/api/v1/hosts

  #curl -X POST -H "Content-type: application/json" -d '{"activated_on":"2013-12-23T00:00:00Z","bootloader_version":"2r2r32r23","created_at":"2013-12-24T11:57:08Z","firmware_version":"222323","hw_config":"2r32r322","id":2,"ip_address":"r32r2r232","mac_address":"r32r32r22","serial_number":324242141,"status":true,"updated_at":"2013-12-24T11:57:08Z"}'  http://localhost:3000/api/v1/hosts

  def create
    @machine = Machine.create(params[:machine])
    if @machine.valid?
      render json:{:status => true}
    else
      #render json:{:status => false, :message => "Unable to register new machine on cloud"}
      render json:{:status => false, :message => @machine.errors.full_messages }
    end
  end

  #def update
  #  @machine.update_attributes(params[:machine])
  #  respond_with(@machine)
  #end

  #curl -X DELETE     http://localhost:3000/api/v1/hosts/324242141

  def destroy
    @machine = Machine.where(:serial_number => params[:serial_id]).first
    if @machine.destroy
      render json:{:status => true}
    else
      render json:{:status => false, :message => @machine.errors.full_messages }
    end
  end

  #private
  #
  #def find_machine
  #  @machine = Machine.find(params[:id])
  #rescue ActiveRecord::RecordNotFound
  #  error = { :error => "The machine you were looking for could not be found."}
  #  respond_with(error, :status => 404)
  #end

end