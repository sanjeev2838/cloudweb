class ParentProfilesController < ApplicationController

  def index
    @parent_profiles = ParentProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parent_profiles }
    end
  end

  def show
    @parent_profile = ParentProfile.find(params[:id])
    #@child_profiles = ChildProfile.find_all_by_parent_profile_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parent_profile }
    end
  end

  def new
    @parent_profile = ParentProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parent_profile }
    end
  end

  def edit
    @parent_profile = ParentProfile.find(params[:id])
  end

  def create
    @parent_profile = ParentProfile.new(params[:parent_profile])

    respond_to do |format|
      if @parent_profile.save!
        format.html { redirect_to @parent_profile, notice: 'Parent profile was successfully created.' }
        format.json { render json: @parent_profile, status: :created, location: @parent_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @parent_profile.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @parent_profile = ParentProfile.find(params[:id])
    @parent_profile.destroy

    respond_to do |format|
      format.html { redirect_to parent_profiles_url }
      format.json { head :no_content }
    end
  end
end
