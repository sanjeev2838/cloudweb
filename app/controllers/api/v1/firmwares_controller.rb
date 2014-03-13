class Api::V1::FirmwaresController <  Api::V1::BaseController
  before_filter :find_machine
  # GET /firmwares
  # GET /firmwares.json

  #def index
  #  @firmwares = Firmware.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @firmwares }
  #  end
  #end
  #
  ## GET /firmwares/1
  ## GET /firmwares/1.json
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
  #
  ## GET /firmwares/new
  ## GET /firmwares/new.json
  #def new
  #  @firmware = Firmware.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @firmware }
  #  end
  #end
  #
  ## GET /firmwares/1/edit
  #def edit
  #  @firmware = Firmware.find(params[:id])
  #end
  #
  ## POST /firmwares
  ## POST /firmwares.json
  #def create
  #  require 'fileutils'
  #  @firmware = Firmware.new(params[:firmware])
  #  respond_to do |format|
  #    unless params[:firmware][:binaryfile].nil?
  #      original_filename =  params[:firmware][:binaryfile].original_filename.to_s
  #      tmp = params[:firmware][:binaryfile].tempfile
  #      file = File.join("public/firmware", params[:firmware][:binaryfile].original_filename)
  #      FileUtils.cp tmp.path, file
  #      params[:firmware].delete :binaryfile
  #      @firmware.binaryfile = "public/firmware/#{original_filename}"
  #    end
  #    if @firmware.save
  #        format.html { redirect_to @firmware, notice: 'Firmware was successfully created.' }
  #        format.json { render json: @firmware, status: :created, location: @firmware }
  #    else
  #        format.html { render action: "new" }
  #        format.json { render json: @firmware.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PUT /firmwares/1
  ## PUT /firmwares/1.json
  #def update
  #  @firmware = Firmware.find(params[:id])
  #
  #  respond_to do |format|
  #    if @firmware.update_attributes(params[:firmware])
  #      format.html { redirect_to @firmware, notice: 'Firmware was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @firmware.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## DELETE /firmwares/1
  ## DELETE /firmwares/1.json
  #def destroy
  #  @firmware = Firmware.find(params[:id])
  #  @firmware.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to firmwares_url }
  #    format.json { head :no_content }
  #  end
  #end
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
