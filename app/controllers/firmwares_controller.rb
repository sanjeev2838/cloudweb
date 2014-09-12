class FirmwaresController < ApplicationController

  def index
    @firmwares = Firmware.where(:status=>true)

    respond_to do |format|
      format.html
      format.json { render json: @firmwares }
    end
  end

  def show
    @firmware = Firmware.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @firmware }
    end
  end

  def new
    @firmware = Firmware.new

    respond_to do |format|
      format.html
      format.json { render json: @firmware }
    end
  end

  def edit
    @firmware = Firmware.find(params[:id])
  end

  def create
    require 'fileutils'
    params[:firmware] = (params[:firmware]).merge(:status => true)
    @firmware = Firmware.new(params[:firmware])
    respond_to do |format|
      unless params[:firmware][:binaryfile].nil?
        original_filename =  params[:firmware][:binaryfile].original_filename.to_s
        tmp = params[:firmware][:binaryfile].tempfile
        file = File.join("public/firmware", params[:firmware][:binaryfile].original_filename)
        FileUtils.cp tmp.path, file
        params[:firmware].delete :binaryfile

        @firmware.binaryfile = "public/firmware/#{original_filename}"
      end
      if @firmware.save
          format.html { redirect_to @firmware, notice: 'Firmware was successfully created.' }
          format.json { render json: @firmware, status: :created, location: @firmware }
      else
          format.html { render action: "new" }
          format.json { render json: @firmware.errors, status: :unprocessable_entity }
      end
    end
  end

  def download_firmware_file
    @firmware = Firmware.find(params[:id])
    send_file "#{Rails.root}/#{@firmware.binaryfile}"
  end

  def update
    @firmware = Firmware.find(params[:id])

    respond_to do |format|
      if @firmware.update_attributes(params[:firmware])
        format.html { redirect_to @firmware, notice: 'Firmware was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @firmware.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @firmware = Firmware.find(params[:id])
    @firmware.update_attributes(:status=> false)

    respond_to do |format|
      format.html { redirect_to firmwares_url }
      format.json { head :no_content }
    end
  end
end
