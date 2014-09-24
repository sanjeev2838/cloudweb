class Api::V2::ChildBrewingPreferencesController < Api::Default::BaseController

  before_filter :find_profile, :only => [:update,:index]

  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    @child_brewing_preferences = @child_profile.child_brewing_preference

    unless @child_brewing_preferences.nil?
      render json:{:status => true, :status_code=>6000,:message=>"Child brewing preference found",:brew => @child_brewing_preferences }
    else
      render json:{:status => false,:status_code=>6001, :message => "Child brewing preference not found for this id"}
    end
  end

  private
  def find_profile
    @profile = ParentProfile.find(params[:profile_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :status_code=>3006, :message => "Unable to find parent profile on cloud"}
  end
end
