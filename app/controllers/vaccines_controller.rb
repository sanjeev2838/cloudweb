class VaccinesController < ApplicationController

  def index
    @vaccines = Vaccine.all
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
    @languages = Vaccine::LANG
    @vaccine = Vaccine.new
    vaccine_ages = @vaccine.vaccine_ages.build
    vaccine_language = @vaccine.vaccine_languages.build

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
   @vaccine = Vaccine.new(params[:vaccine])

    respond_to do |format|
      if @vaccine.save
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
