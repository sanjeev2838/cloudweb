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

  def import_machine_csv
    puts "the params are #{params}"
    require 'fileutils'
    original_filename =  params[:machine_upload][:file].original_filename
    tmp = params[:machine_upload][:file].tempfile
    puts "the tempfile is #{tmp}"
    @file = tmp
    unless @file.nil?
    begin
    #      order_progress_logfile = File.open("#{RAILS_ROOT}/log/schooldata.log", 'a')
    #      order_progress_logfile.sync = true
    #      schooldata = Logger.new(order_progress_logfile)
    #      directory =  "#{Rails.root}/public/system/School_data"
    #      Spreadsheet.client_encoding = 'UTF-8'
          book = Spreadsheet.open(@file)
          book.worksheets.each do |sheet|
            index = 0
            i = 0
            sheet.each_with_index do |row,ind|
              unless index >= 3
                puts "the row count is #{sheet.count}"
                puts "column count is #{sheet.column_count()}"
    #            column_count = sheet.column_count()
    #            # column_count.times do |col|
    #            student_id=sheet.row(3+i)[2]
    #            school_session_id = sheet.row(3+i)[3]
    #            height = sheet.row(3+i)[4]
    #            weight = sheet.row(3+i)[5]
    #            blood_group = sheet.row(3+i)[6]
    #            v_left = sheet.row(3+i)[7]
    #            v_right = sheet.row(3+i)[8]
    #            teeth = sheet.row(3+i)[9]
    #            oral_hygine= sheet.row(3+i)[10]
    #            s_alinment = sheet.row(3+i)[11]
    #            @health_status = HealthStatus.new
    #            @health_status.student_id = student_id
    #            @health_status.school_session_id =  school_session_id
    #            @health_status.height =height
    #            @health_status.weight = weight
    #            @health_status.blood_group=blood_group
    #            @health_status.vision_left = v_left
    #            @health_status.vision_right = v_right
    #            @health_status.teeth = teeth
    #            @health_status.oral_hygiene = oral_hygine
    #            @health_status.specific_ailment = s_alinment
    #            @previous_health_status = HealthStatus.find_by_student_id_and_school_session_id(student_id,school_session_id)
    #            if @previous_health_status.nil?
    #              if @health_status.valid?
    #                @health_status.save!
    #              else
    #                schooldata.error "Error accured at #{@health_status.attributes} with error message #{@health_status.errors.full_messages}"
    #              end
    #            else
    #              schooldata.error "Error occured at #{@health_status.attributes} with error message #{@health_status.errrors.full_messages}"
    #            end
    #            i = i+1
              else
    #            index=index+1
              end
            end
          end
          flash[:notice] = "Data uploaded successfully"
          redirect_to :controller => "machines",:action => "import_machine_csv"
        rescue Exception => exc
    #      schooldata.error exc
          puts "the error is #{exc}"
        end
    #  #else
    #  #  #schooldata.error "file format is incorrect in student health status"
    #  #  flash[:notice] = "File format is incorrect"
    #  #  redirect_to :controller => "sessions", :action => "dashboard"
    #  #end
    else
      #schooldata.error "File no found"
      flash[:notice] = "File not found error"
      redirect_to root_url
    end
  end



end
