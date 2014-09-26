class Api::V2::MachinesController < Api::Default::BaseController

  def create
   params[:machine]= {}
   params[:machine][:serialid] = params['01']
   params[:machine][:ipaddress] = params['08']
   params[:machine][:firmware] =  params['03']
   params[:machine][:bootloader] = params['02']
   params[:machine][:hwconfig] = params['04']
   params[:machine] = (params[:machine]).merge(:status => false)
   @machine = Machine.new(params[:machine])
    if @machine.save
      render json:{:status => true ,:status_code=>2004,:message=>"Machine created successfully"}
    else
      render json:{:status => false, :status_code => 2005 ,:message => @errors }
    end
  end
end

#sample for post request
  # http://d1.diluo.nu/api/v2/hosts
  #
  # including POST JSON data
  #
  # {
  # “01”:<serial>,
  # “08”:<ipaddress>
  # “03”:<firmware version>,
  # “02”:<bootloader version>,
  # “04”:<hwconfig>,
  # }