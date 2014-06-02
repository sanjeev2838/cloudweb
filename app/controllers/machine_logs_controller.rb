class MachineLogsController < ApplicationController

  def index
    @machine_logs = MachineLog.all

    respond_to do |format|
      format.html
      format.json { render json: @machine_logs }
    end
  end

  def show
    @machine_log = MachineLog.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @machine_log }
    end
  end

  def new
    @machine_log = MachineLog.new

    respond_to do |format|
      format.html
      format.json { render json: @machine_log }
    end
  end

  def edit
    @machine_log = MachineLog.find(params[:id])
  end

  def create
    @machine_log = MachineLog.new(params[:machine_log])

    respond_to do |format|
      if @machine_log.save
        format.html { redirect_to @machine_log, notice: 'Machine log was successfully created.' }
        format.json { render json: @machine_log, status: :created, location: @machine_log }
      else
        format.html { render action: "new" }
        format.json { render json: @machine_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @machine_log = MachineLog.find(params[:id])

    respond_to do |format|
      if @machine_log.update_attributes(params[:machine_log])
        format.html { redirect_to @machine_log, notice: 'Machine log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @machine_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @machine_log = MachineLog.find(params[:id])
    @machine_log.destroy

    respond_to do |format|
      format.html { redirect_to machine_logs_url }
      format.json { head :no_content }
    end
  end
end
