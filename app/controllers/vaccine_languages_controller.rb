class VaccineLanguagesController < ApplicationController

  def index
    @vaccine_languages = VaccineLanguage.all

    respond_to do |format|
      format.html
      format.json { render json: @vaccine_languages }
    end
  end

  def show
    @vaccine_language = VaccineLanguage.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @vaccine_language }
    end
  end

  def new
    @vaccine_language = VaccineLanguage.new

    respond_to do |format|
      format.html
      format.json { render json: @vaccine_language }
    end
  end

  def edit
    @vaccine_language = VaccineLanguage.find(params[:id])
  end

  def create
    @vaccine_language = VaccineLanguage.new(vaccine_language_params)

    respond_to do |format|
      if @vaccine_language.save
        format.html { redirect_to @vaccine_language, notice: 'Vaccine language was successfully created.' }
        format.json { render json: @vaccine_language, status: :created, location: @vaccine_language }
      else
        format.html { render action: "new" }
        format.json { render json: @vaccine_language.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @vaccine_language = VaccineLanguage.find(params[:id])

    respond_to do |format|
      if @vaccine_language.update_attributes(vaccine_language_params)
        format.html { redirect_to @vaccine_language, notice: 'Vaccine language was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vaccine_language.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vaccine_language = VaccineLanguage.find(params[:id])
    @vaccine_language.destroy

    respond_to do |format|
      format.html { redirect_to vaccine_languages_url }
      format.json { head :no_content }
    end
  end

  private
    def vaccine_language_params
      params.require(:vaccine_language).permit()
    end
end
