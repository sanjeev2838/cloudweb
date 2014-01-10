class Api::V1::ChildBrewingPreferencesController < Api::V1::BaseController
  # GET /child_brewing_preferences
  # GET /child_brewing_preferences.json
  before_filter :find_profile, :only => [:update,:index]

  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    @child_brewing_preferences = @child_profile.child_brewing_preference

    unless @child_brewing_preferences.nil?
      render json:{:status => true, :temperature => @child_brewing_preferences.temperature, :milk=>@child_brewing_preferences.milk}
    else
      render json:{:status => false, :message => "Child brewing preference not found for this id"}
    end
  end

  def update
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    @child_brewing_preference = @child_profile.child_brewing_preference

    if @child_brewing_preference.update_attributes(params[:child_brewing_preference])
       render json:{:status => true, :message => "Child brewing preference updated successfully"}
    else
       render json:{:status => false, :message => "Child not found for this id"}
    end
  end


  private
  def find_profile
    @profile = ParentProfile.find(params[:profile_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find parent profile on cloud"}
  end
end
