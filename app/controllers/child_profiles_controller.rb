
class ChildProfilesController < ApplicationController
  before_filter :find_profile, :only => [:new, :create,:show,:edit,:index,:update, :destroy]

  def show
    @parent_profile= ParentProfile.find(params[:parent_profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:id])
    @brewing_preference = @child_profile.child_brewing_preference
    @machine = Machine.find(@parent_profile.machine_id)
    @child_state = ChildStat.find_all_by_child_profile_id(params[:id])
    @logs = Logbook.find_all_by_child_profile_id(params[:id])
    @dairy = Diary.find_all_by_child_profile_id(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child_profile }
    end
  end

  def new
    @child_profile = @parent_profile.child_profiles.build
    @child_profile.child_brewing_preference = ChildBrewingPreference.new
    @child_profile.pictures.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child_profile }
    end
  end

  def edit
    @child_profile = ChildProfile.find(params[:id])
    @child_profile.child_brewing_preference = ChildBrewingPreference.find_by_child_profile_id(params[:id])
  end

  def create
    @child_profile = @parent_profile.child_profiles.create(params[:child_profile])
    respond_to do |format|
      if @child_profile.save
        format.html { redirect_to parent_profiles_path, notice: 'Child profile was successfully created.' }
        format.json { render json: @child_profile, status: :created, location: @child_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @child_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @parent_profile = ParentProfile.find(params[:parent_profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:id])

    respond_to do |format|
      if @child_profile.update_attributes(params[:child_profile])
        format.html { redirect_to  parent_profile_child_profile_path(@parent_profile,@child_profile), notice: 'Child profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @child_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def find_profile
    @parent_profile = ParentProfile.find(params[:parent_profile_id])
  end
end
