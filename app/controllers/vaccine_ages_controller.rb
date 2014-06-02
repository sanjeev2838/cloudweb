class VaccineAgesController < ApplicationController

  def index
    @vaccine_ages = VaccineAge.all

    respond_to do |format|
      format.html
      format.json { render json: @vaccine_ages }
    end
  end

  def show
    @vaccine_age = VaccineAge.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @vaccine_age }
    end
  end

  def new
    @vaccine_age = VaccineAge.new

    respond_to do |format|
      format.html
      format.json { render json: @vaccine_age }
    end
  end

  def edit
    @vaccine_age = VaccineAge.find(params[:id])
  end

  def create
    @vaccine_age = VaccineAge.new(vaccine_age_params)

    respond_to do |format|
      if @vaccine_age.save
        format.html { redirect_to @vaccine_age, notice: 'Vaccine age was successfully created.' }
        format.json { render json: @vaccine_age, status: :created, location: @vaccine_age }
      else
        format.html { render action: "new" }
        format.json { render json: @vaccine_age.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @vaccine_age = VaccineAge.find(params[:id])

    respond_to do |format|
      if @vaccine_age.update_attributes(vaccine_age_params)
        format.html { redirect_to @vaccine_age, notice: 'Vaccine age was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vaccine_age.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vaccine_age = VaccineAge.find(params[:id])
    @vaccine_age.destroy

    respond_to do |format|
      format.html { redirect_to vaccine_ages_url }
      format.json { head :no_content }
    end
  end

  private

    def vaccine_age_params
      params.require(:vaccine_age).permit()
    end
end
