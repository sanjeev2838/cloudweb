class Api::V1::FirmwaresController <  Api::V1::BaseController
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
    begin
    @machine = Machine.find_by_serialid(params[:machine_id])
    raise  ActiveRecord::RecordNotFound if @machine.nil?
    rescue ActiveRecord::RecordNotFound
      render json:{:status => false, :message => "unable to find machine on cloud"}
    end
  end


end
