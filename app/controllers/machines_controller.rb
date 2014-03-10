class MachinesController < ApplicationController
  ## GET /machines
  ## GET /machines.json
  def index
    @active_machines = Machine.where(:status=>true)
    @inactive_machines = Machine.where(:status=>false)

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
    @parent_profile= ParentProfile.find_all_by_machine_id(params[:id])
    @parent_profile.each do |profile|
      profile.update_column(:machine_id , nil)
    end
    @machine.update_column(:status,false)


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
          Spreadsheet.client_encoding = 'UTF-8'
          book = Spreadsheet.open(@file)
          book.worksheets.each do |sheet|
            index = 0
            i = 0
            sheet.each_with_index do |row,ind|
              unless index >= 3
                column_count = sheet.column_count()
                column_count.times do |col|
                  serial_id=sheet.row(3+i)[0]
                  firmware = sheet.row(3+i)[1]
                  hw_config = sheet.row(3+i)[2]
                  mac_address = sheet.row(3+i)[3]
                  ip_address = sheet.row(3+i)[4]
                  boot_loader = sheet.row(3+i)[5]
                  colour = sheet.row(3+i)[6]
                  status = sheet.row(3+i)[7]

                  @machine = Machine.new
                  @machine.serialid=serial_id
                  @machine.firmware=firmware
                  @machine.hwconfig=hw_config
                  @machine.macaddress=mac_address
                  @machine.ipaddress=ip_address
                  @machine.bootloader=boot_loader
                  @machine.color=colour
                  @machine.status=status
                  if @machine.valid?
                      @machine.save!
                    else
                      puts "the error is  #{@machine.errors.full_messages}"
                    end
                  i = i+1
                end
              else
                index=index+1
              end
            end
          end
          flash[:notice] = "Data uploaded successfully"
          redirect_to admin_dashboard_index_path
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
      redirect_to admin_dashboard_index_path
    end
  end



end
