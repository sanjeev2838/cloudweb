class ChildBrewingPreferencesController < ApplicationController
  # GET /child_brewing_preferences
  # GET /child_brewing_preferences.json
  def index
    @child_brewing_preferences = ChildBrewingPreference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @child_brewing_preferences }
    end
  end

  # GET /child_brewing_preferences/1
  # GET /child_brewing_preferences/1.json
  def show
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child_brewing_preference }
    end
  end

  # GET /child_brewing_preferences/new
  # GET /child_brewing_preferences/new.json
  def new
    @child_brewing_preference = ChildBrewingPreference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child_brewing_preference }
    end
  end

  # GET /child_brewing_preferences/1/edit
  def edit
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])
  end

  # POST /child_brewing_preferences
  # POST /child_brewing_preferences.json
  def create
    @child_brewing_preference = ChildBrewingPreference.new(params[:child_brewing_preference])

    respond_to do |format|
      if @child_brewing_preference.save
        format.html { redirect_to @child_brewing_preference, notice: 'Child brewing preference was successfully created.' }
        format.json { render json: @child_brewing_preference, status: :created, location: @child_brewing_preference }
      else
        format.html { render action: "new" }
        format.json { render json: @child_brewing_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /child_brewing_preferences/1
  # PUT /child_brewing_preferences/1.json
  def update
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])

    respond_to do |format|
      if @child_brewing_preference.update_attributes(params[:child_brewing_preference])
        format.html { redirect_to @child_brewing_preference, notice: 'Child brewing preference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @child_brewing_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /child_brewing_preferences/1
  # DELETE /child_brewing_preferences/1.json
  def destroy
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])
    @child_brewing_preference.destroy

    respond_to do |format|
      format.html { redirect_to child_brewing_preferences_url }
      format.json { head :no_content }
    end
  end
end
