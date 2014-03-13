class VaccinesController < ApplicationController

  def index
    @vaccines = Vaccine.where(:status => true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vaccines }
    end
  end

  def show
    @vaccine = Vaccine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vaccine }
    end
  end

  def new
    @vaccine = Vaccine.new
    @languages = Vaccine::LANG
    @vaccine_ages = @vaccine.vaccine_ages.build
    3.times {@vaccine.vaccine_ages.build}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vaccine }
    end
  end

  def edit
    @vaccine = Vaccine.find(params[:id])
    @languages = Vaccine::LANG
  end

  def create
    @languages = Vaccine::LANG
    @vaccine = Vaccine.create(:title=>params[:title],:status=>true)

    respond_to do |format|
      if @vaccine.save
        @vaccine_languge = VaccineLanguage.create(:title=>params[:sv],:vaccine_id=>@vaccine.id,:locale=>"sv") unless params[:sv].nil?
        @vaccine_languge = VaccineLanguage.create(:title=>params[:no],:vaccine_id=>@vaccine.id,:locale=>"no") unless params[:no].nil?
        @vaccine_languge = VaccineLanguage.create(:title=>params[:en],:vaccine_id=>@vaccine.id,:locale=>"en") unless params[:en].nil?
        params[:count].to_i.times do |i|
          age = params["age#{i}"]
          @vaccine_age = VaccineAge.create(:age=>age,:vaccine_id=>@vaccine.id)
        end
        format.html { redirect_to @vaccine, notice: 'Vaccine was successfully created.' }
        format.json { render json: @vaccine, status: :created, location: @vaccine }
      else
        format.html { render action: "new" }
        format.json { render json: @vaccine.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @vaccine = Vaccine.find(params[:id])

    respond_to do |format|
      if @vaccine.update_attributes(params[:vaccine])
        format.html { redirect_to @vaccine, notice: 'Vaccine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vaccine.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vaccine = Vaccine.find(params[:id])
    @vaccine.update_attributes(:status=>false)

    respond_to do |format|
      format.html { redirect_to vaccines_url }
      format.json { head :no_content }
    end
  end
end
