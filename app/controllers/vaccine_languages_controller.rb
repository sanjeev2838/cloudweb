class VaccineLanguagesController < ApplicationController
  # GET /vaccine_languages
  # GET /vaccine_languages.json
  def index
    @vaccine_languages = VaccineLanguage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vaccine_languages }
    end
  end

  # GET /vaccine_languages/1
  # GET /vaccine_languages/1.json
  def show
    @vaccine_language = VaccineLanguage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vaccine_language }
    end
  end

  # GET /vaccine_languages/new
  # GET /vaccine_languages/new.json
  def new
    @vaccine_language = VaccineLanguage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vaccine_language }
    end
  end

  # GET /vaccine_languages/1/edit
  def edit
    @vaccine_language = VaccineLanguage.find(params[:id])
  end

  # POST /vaccine_languages
  # POST /vaccine_languages.json
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

  # PATCH/PUT /vaccine_languages/1
  # PATCH/PUT /vaccine_languages/1.json
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

  # DELETE /vaccine_languages/1
  # DELETE /vaccine_languages/1.json
  def destroy
    @vaccine_language = VaccineLanguage.find(params[:id])
    @vaccine_language.destroy

    respond_to do |format|
      format.html { redirect_to vaccine_languages_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def vaccine_language_params
      params.require(:vaccine_language).permit()
    end
end
