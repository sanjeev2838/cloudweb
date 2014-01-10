class Api::V1::MachinesController < Api::V1::BaseController
  respond_to :json

  def show
   #require "digest"
   #auth_code = Digest::MD5.hexdigest("techno$garden")
   if "5e7add11cb09a9e70061776727555f4c" == params[:authcode]
      @machine = Machine.where(:serialid => params[:serialid]).first
      unless @machine.nil?
        render action: :show
      else
        render json:{:status => false, :message=> "Machine not found for this serial no."}
      end
   else
     render json:{:status => false, :message=> "authcode not matched"}
   end
  end


  def create
    params[:machine] = (params[:machine]).merge(:status => false)
    @machine = Machine.create(params[:machine])
    if @machine.valid?
      render json:{:status => true }
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