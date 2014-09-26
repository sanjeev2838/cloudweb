class Api::V1::FirmwaresController <  Api::Default::BaseController
  before_filter :find_machine

  def show
    @firmware = Firmware.all
    @all_firmware = []
    @firmware.each do |firm|
      machine = firm.serialids.split(',')
      if machine.include?(@machine.serialid.to_s)
          @all_firmware << firm
      end
    end

    if !@all_firmware.blank?
     @latest_firmware = @all_firmware.sort!{|a,b| a.created_at <=> b.created_at}.last
    end

    if @latest_firmware
      extension = File.extname(@latest_firmware.binaryfile)
      filename = File.basename(@latest_firmware.binaryfile, extension)
      @binary_file = download_firmware_url(@latest_firmware, filename, extension.gsub(/\./, ''))
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
