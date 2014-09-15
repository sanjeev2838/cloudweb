class Api::V1::FirmwaresController <  Api::Default::BaseController
  before_filter :find_machine

  def show
    @firmware = Firmware.all
    @firmware.each do |firm|
      @all_firmware = []
      machine = firm.serialids.split(',')
      if machine.include?(@machine.serialid.to_s)
          @all_firmware << firm
      end
      @all_firmware
    end
    @binary_file = ""
    unless @all_firmware.nil?
     latest_firmware=@all_firmware.sort!{|a,b| a.created_at <=> b.created_at}
     @binary_file = latest_firmware.map { |x| x[:binaryfile] }.join(',')
    end

    unless @binary_file == ""
      render action: :show
    else
      render json:{:status => false, :message => "No firmware release found for this machine"}
    end

  end

  private
  def find_machine
    @machine = Machine.find_by_serialid(params[:machine_id])
    if @machine.nil?
      render json:{:status => false, :message => "unable to find machine on cloud"}
      return
    end
  end

end
