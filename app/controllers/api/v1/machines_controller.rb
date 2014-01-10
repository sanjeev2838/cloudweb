class Api::V1::MachinesController < Api::V1::BaseController
  respond_to :json

  def create
    params[:machine] = (params[:machine]).merge(:status => false)
    @machine = Machine.create(params[:machine])
    if @machine.valid?
      render action: :show
      #render json:{:status => true}
    else
      render json:{:status => false, :message => @machine.errors.full_messages }
    end
  end

  def destroy
    @machine = Machine.where(:serialid => params[:serialid]).first
    if @machine.nil?
      render json:{:status => false, :message => "please provide valid serial id" }
    else
      if @machine.update_attributes(:status => false)
        render json:{:status => true}
      else
      render json:{:status => false, :message => @machine.errors.full_messages }
      end
    end
  end

end