class ParentProfilesController < ApplicationController
  # GET /parent_profiles
  # GET /parent_profiles.json
  def index
    @parent_profiles = ParentProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parent_profiles }
    end
  end

  # GET /parent_profiles/1
  # GET /parent_profiles/1.json
  def show
    @parent_profile = ParentProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parent_profile }
    end
  end

  # GET /parent_profiles/new
  # GET /parent_profiles/new.json
  def new
    @parent_profile = ParentProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parent_profile }
    end
  end

  # GET /parent_profiles/1/edit
  def edit
    @parent_profile = ParentProfile.find(params[:id])
  end

  # POST /parent_profiles
  # POST /parent_profiles.json
  def create
    @parent_profile = ParentProfile.new(params[:parent_profile])

    respond_to do |format|
      if @parent_profile.save
        format.html { redirect_to @parent_profile, notice: 'Parent profile was successfully created.' }
        format.json { render json: @parent_profile, status: :created, location: @parent_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @parent_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parent_profiles/1
  # PUT /parent_profiles/1.json
  def update
    @parent_profile = ParentProfile.find(params[:id])

    respond_to do |format|
      if @parent_profile.update_attributes(params[:parent_profile])
        format.html { redirect_to @parent_profile, notice: 'Parent profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parent_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parent_profiles/1
  # DELETE /parent_profiles/1.json
  def destroy
    @parent_profile = ParentProfile.find(params[:id])
    @parent_profile.destroy

    respond_to do |format|
      format.html { redirect_to parent_profiles_url }
      format.json { head :no_content }
    end
  end
end
