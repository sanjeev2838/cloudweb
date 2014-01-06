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
  #def show
  #  @child_profile = @parent_profile.child_profiles.where(:id =>params[:id])
  #  @brewing_preference = @child_profile.brewing_preference
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @child_profile }
  #  end
  #end


  def new
    @child_profile = @parent_profile.child_profiles.build
    #@child_profile = @parent_profile.build_child_profile
   # @child_brewing_preference = @child_profile.child_brewing_preference.new
    @child_profile.child_brewing_preference = ChildBrewingPreference.new
    @child_profile.picture =  Picture.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child_profile }
    end
  end

  #
  #def edit
  #  @child_profile = ChildProfile.find(params[:id])
  #end
  #

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


  #def update
  #  @child_profile = @parent_profile.child_profiles.find(params[:id])
  #
  #  respond_to do |format|
  #    if @child_profile.update_attributes(params[:child_profile])
  #      format.html { redirect_to @child_profile, notice: 'Child profile was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @child_profile.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
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
