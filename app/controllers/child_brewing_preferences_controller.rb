class ChildBrewingPreferencesController < ApplicationController

  def index
    @child_brewing_preferences = ChildBrewingPreference.all

    respond_to do |format|
      format.html
      format.json { render json: @child_brewing_preferences }
    end
  end

  def show
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @child_brewing_preference }
    end
  end

  def new
    @child_brewing_preference = ChildBrewingPreference.new

    respond_to do |format|
      format.html
      format.json { render json: @child_brewing_preference }
    end
  end

  def edit
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])
  end

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

  def destroy
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])
    @child_brewing_preference.destroy

    respond_to do |format|
      format.html { redirect_to child_brewing_preferences_url }
      format.json { head :no_content }
    end
  end
end
