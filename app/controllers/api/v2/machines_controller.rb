class Api::V2::MachinesController < Api::Default::BaseController
#'{"01":0123456789ABCDEF%2C"08":192.168.0.50:"03":001%2C"02":001%2C"04":0%2C"05":no_error%2C"06":37%2C"07":3}'
#'{"01":"0123456789ABCDEF", "08":"192.168.0.50","03":"001","02":"001", "04":"0","05":"no_error", "06":"37", "07":"3"}'
# Invalid request '{"01":0123456789ABCDEF, "08":192.168.0.50,"03":001,"02":001, "04":0,"05":no_error, "06":37, "07":3}'

#correct string to request :- "{"01":"0123456789ABCDEF"%2C "08":"192.168.0.50"%2C"03":"001"%2C"02":"001"%2C "04":"0"%2C"05":"no_error"%2C "06":"37"%2C "07":"3"}"

  def create
   string  = (params[:data]).gsub('%2C', ',') if params[:data]
   machine_params  = JSON.parse(string)
   logger.debug "New post: #{@post.attributes.inspect}"
   params[:machine]= {}
   params[:machine][:serialid] = machine_params['01']
   params[:machine][:ipaddress] = machine_params['08']
   params[:machine][:firmware] =  machine_params['03']
   params[:machine][:bootloader] = machine_params['02']
   params[:machine][:hwconfig] = machine_params['04']
   params[:machine] = (params[:machine]).merge(:status => false)
   @machine = Machine.new(params[:machine])
    if @machine.save
      render json:{:status => true ,:status_code=>2004,:message=>"Machine created successfully"}
    else
      render json:{:status => false, :status_code => 2005 ,:message => @machine.errors }
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

# {
# "01":<serial>,
# "08":<ipaddress>
# "03":<firmware version>,
# "02":<bootloader version>,
# "04":<hwconfig>,
# "05" :<Errormessage>,
# "06" :<Temperature>,
# "07" :<PSU_voltage>
# }