class MachineLogsController < ApplicationController
  # GET /machine_logs
  # GET /machine_logs.json
  def index
    @machine_logs = MachineLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @machine_logs }
    end
  end

  # GET /machine_logs/1
  # GET /machine_logs/1.json
  def show
    @machine_log = MachineLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @machine_log }
    end
  end

  # GET /machine_logs/new
  # GET /machine_logs/new.json
  def new
    @machine_log = MachineLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @machine_log }
    end
  end

  # GET /machine_logs/1/edit
  def edit
    @machine_log = MachineLog.find(params[:id])
  end

  # POST /machine_logs
  # POST /machine_logs.json
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

  # PUT /machine_logs/1
  # PUT /machine_logs/1.json
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

  # DELETE /machine_logs/1
  # DELETE /machine_logs/1.json
  def destroy
    @machine_log = MachineLog.find(params[:id])
    @machine_log.destroy

    respond_to do |format|
      format.html { redirect_to machine_logs_url }
      format.json { head :no_content }
    end
  end
end
