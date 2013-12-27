class ChildProfilesController < ApplicationController

  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profiles = ChildProfile.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @child_profiles }
    end
  end


  def show
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.where(:id =>params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child_profile }
    end
  end


  def new
    @child_profile = ChildProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child_profile }
    end
  end


  def edit
    @child_profile = ChildProfile.find(params[:id])
  end


  def create
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.create(params[:children])

    respond_to do |format|
      if @child_profile.save
        format.html { redirect_to @child_profile, notice: 'Child profile was successfully created.' }
        format.json { render json: @child_profile, status: :created, location: @child_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @child_profile.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:id])

    respond_to do |format|
      if @child_profile.update_attributes(params[:child_profile])
        format.html { redirect_to @child_profile, notice: 'Child profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @child_profile.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:id])
    @child_profile.destroy

    respond_to do |format|
      format.html { redirect_to child_profiles_url }
      format.json { head :no_content }
    end
  end
end
