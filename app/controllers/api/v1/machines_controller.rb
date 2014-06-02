class Api::V1::MachinesController < Api::V1::BaseController
  before_filter :find_machine, :only => [:show, :update, :destroy]

  def show
    if "5e7add11cb09a9e70061776727555f4c" == params[:authcode]
      render action: :show  unless @machine
    else
      render json:{:status => false ,:status_code=>2002, :message=> "authcode not matched"}
    end
  end

  def update
    if params[:color].empty?
      render json:{:status => false, :status_code=>2003,:message=> "provide color as parameter to update "}
      return
    end
    if "5e7add11cb09a9e70061776727555f4c" == params[:authcode]
      render action: :show   if  @machine.update_attributes(:color => params[:color])
    else
      render json:{:status => false,:status_code=>2002 ,:message=> "authcode not matched "}
    end
  end

  def create
    if params[:machine].nil?
      params[:machine]= {}
      params[:machine][:serialid] = params[:serialid]
      params[:machine][:ipaddress] = params[:ipaddress]
      params[:machine][:firmware] =  params[:firmware]
      params[:machine][:bootloader] = params[:bootloader]
      params[:machine][:hwconfig] = params[:hwconfig]
      params[:machine][:macaddress] = params[:macaddress]
    end
   params[:machine] = (params[:machine]).merge(:status => false)
   @machine = Machine.create(params[:machine])
    if @machine.valid?
      render json:{:status => true ,:status_code=>2004,:message=>"Machine created successfully"}
    else
      @errors=[]
      @codes=[]
      error = {"serialid"=>2000,"ipaddress"=>2001,"firmware"=>2002,"bootloader"=>2003,"hwconfig"=>2004,"macaddress"=>2005}

      render json:{:status => false, :status_code => 2005 ,:message => @errors }
    end
  end

  def destroy
    if @machine.update_attributes(:status => false)
      render json:{:status => true,:status_code=>2006,:message=> "Machine deleted successfully"}
    else
      render json:{:status => false, :status_code=>2007,:message => @machine.errors.full_messages }
    end
  end

  private
  def find_machine
    begin
      @machine = Machine.find_by_serialid(params[:serialid])
      raise  ActiveRecord::RecordNotFound if @machine.nil?
    rescue ActiveRecord::RecordNotFound  => exception
      render json:{:status => false, :status_code=>2000,:message => "Machine not Found"}
    end
  end


end