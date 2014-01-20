class MachinesController < ApplicationController
  ## GET /machines
  ## GET /machines.json
  def index
    @machines = Machine.order("serialid").page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @machines, :status => :true }
    end
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
    @machine = Machine.find(params[:id])
    @machine_logs = MachineLog.order(:created_at => :asc).find_all_by_machine_id(params[:id])
    @owner = ParentProfile.find_by_machine_id(params[:id],:conditions=>{:is_machine_owner=>true})
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @machine }
    end
  end

  # GET /machines/new
  # GET /machines/new.json
  def new
    @machine = Machine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @machine }
    end
  end

  # GET /machines/1/edit
  def edit
    @machine = Machine.find(params[:id])
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(params[:machine])

    respond_to do |format|
      if @machine.save
        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render json: @machine, status: :created, location: @machine }
      else
        format.html { render action: "new" }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /machines/1
  # PUT /machines/1.json
  def update
    @machine = Machine.find(params[:id])

    respond_to do |format|
      if @machine.update_attributes(params[:machine])
        format.html { redirect_to @machine, notice: 'Machine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    @machine = Machine.find(params[:id])
    @machine.destroy

    respond_to do |format|
      format.html { redirect_to machines_url }
      format.json { head :no_content }
    end
  end

  def machines_import

  end

  def machine_csv_download

    respond_to do |format|
      format.html
      format.rss
      format.xls {
        send_data(generate_csv , :type=>"application/ms-excel", :filename => "Machines.xls",:orientation=>"landscape",:margin=>{:top=>0.25,:bottom=>0.25,:left=>0.25,:header=>0.05})
      }
    end
  end


end
