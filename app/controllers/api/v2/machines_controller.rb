require 'json'
class Api::V2::MachinesController < Api::Default::BaseController
#'{"01":0123456789ABCDEF%2C"08":192.168.0.50:"03":001%2C"02":001%2C"04":0%2C"05":no_error%2C"06":37%2C"07":3}'
#'{"01":"0123456789ABCDEF", "08":"192.168.0.50","03":"001","02":"001", "04":"0","05":"no_error", "06":"37", "07":"3"}'
# Invalid request '{"01":0123456789ABCDEF, "08":192.168.0.50,"03":001,"02":001, "04":0,"05":no_error, "06":37, "07":3}'

#correct string to request :- "{"01":"0123456789ABCDEF"%2C "08":"192.168.0.50"%2C"03":"001"%2C"02":"001"%2C "04":"0"%2C"05":"no_error"%2C "06":"37"%2C "07":"3"}"

  def create
   string  = (params[:data]).gsub('%2C', ',') if params[:data]
   machine_params  = JSON.parse(string)
   logger.debug "New Log entry: #{machine_params}"
   params[:machine]= {}
   params[:machine][:serialid] = machine_params['01']
   params[:machine][:ipaddress] = machine_params['08']
   params[:machine][:firmware] =  machine_params['03']
   params[:machine][:bootloader] = machine_params['02']
   params[:machine][:hwconfig] = machine_params['04']
   params[:machine][:error_msg] = machine_params['05']
   params[:machine][:temp] =  machine_params['06']
   params[:machine][:psu_voltage] = machine_params['07']
   profile_hash  = {}
   9.upto(31).each do |item|
     item  = (item == 9 ) ?  '0' << item.to_s : item.to_s
     if  machine_params[item]
       profile_hash[item] = machine_params[item]
     else
       profile_hash[item] = nil
     end
   end
   @machine = Machine.find_by_serialid(params[:machine][:serialid]) if params[:machine][:serialid]
   if @machine.nil?
     params[:machine][:host_profile] = profile_hash.to_json
     params[:machine] = (params[:machine]).merge(:status => true)
     @machine = Machine.new(params[:machine])
     if @machine.save
       render json:{:status => true ,:status_code=>2004,:message=>"Machine created successfully"}
     else
       render json:{:status => false, :status_code => 2005 ,:message => @machine.errors }
     end
   else
     host_profile = JSON.parse(@machine.host_profile)
     host_profile.each do |key, value|
       host_profile[key] = profile_hash[key] if profile_hash[key]
     end
     params[:machine][:host_profile] = host_profile.to_json
     if @machine.update_attributes(params[:machine])
       render json:{:status => true ,:status_code=>2004,:message=>"Machine updated successfully"}
     else
       render json:{:status => false, :status_code => 2005 ,:message => @machine.errors }
     end
   end
  end

  def gethostprofile
    string  = (params[:data]).gsub('%2C', ',') if params[:data]
    params  = JSON.parse(string)
    logger.debug "New Log entry: #{params}"
    @machine = Machine.find_by_serialid(params['01']) if params['01']
    if @machine.nil?
      render json:{:status => false, :message => "please provide valid serialid " }
    else
      host_profile  = JSON.parse(@machine.host_profile) if @machine.host_profile
      host_profile = nil if host_profile.blank?
      render json:{:status => true ,'01' => @machine.serialid, '06'=> host_profile }
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