class VaccineAgesController < ApplicationController
  # GET /vaccine_ages
  # GET /vaccine_ages.json
  def index
    @vaccine_ages = VaccineAge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vaccine_ages }
    end
  end

  # GET /vaccine_ages/1
  # GET /vaccine_ages/1.json
  def show
    @vaccine_age = VaccineAge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vaccine_age }
    end
  end

  # GET /vaccine_ages/new
  # GET /vaccine_ages/new.json
  def new
    @vaccine_age = VaccineAge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vaccine_age }
    end
  end

  # GET /vaccine_ages/1/edit
  def edit
    @vaccine_age = VaccineAge.find(params[:id])
  end

  # POST /vaccine_ages
  # POST /vaccine_ages.json
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

  # PATCH/PUT /vaccine_ages/1
  # PATCH/PUT /vaccine_ages/1.json
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

  # DELETE /vaccine_ages/1
  # DELETE /vaccine_ages/1.json
  def destroy
    @vaccine_age = VaccineAge.find(params[:id])
    @vaccine_age.destroy

    respond_to do |format|
      format.html { redirect_to vaccine_ages_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def vaccine_age_params
      params.require(:vaccine_age).permit()
    end
end
