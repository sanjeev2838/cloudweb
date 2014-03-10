
class ChildProfilesController < ApplicationController
  before_filter :find_profile, :only => [:new, :create,:show,:edit,:index,:update, :destroy]

  #def index
  #  @child_profiles = ChildProfile.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @child_profiles }
  #  end
  #end
  #
  #
  def show
    @parent_profile= ParentProfile.find(params[:parent_profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:id])
    @brewing_preference = @child_profile.child_brewing_preference
    @machine = Machine.find(@parent_profile.machine_id)
    @child_state = ChildStat.find_all_by_child_profile_id(params[:id])
    @logs = Logbook.find_all_by_child_profile_id(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child_profile }
    end
  end


  def new
    @child_profile = @parent_profile.child_profiles.build
    #@child_profile = @parent_profile.build_child_profile
   # @child_brewing_preference = @child_profile.child_brewing_preference.new
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

    #@child_brewing_preference = @child_profile.child_brewing_preference

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
  #
  #
  #def destroy
  #  @child_profile = @parent_profile.child_profiles.find(params[:id])
  #  @child_profile.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to child_profiles_url }
  #    format.json { head :no_content }
  #  end
  #end

  private

  def find_profile
    @parent_profile = ParentProfile.find(params[:parent_profile_id])
  end
end
