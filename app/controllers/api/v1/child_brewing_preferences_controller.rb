class Api::V1::ChildBrewingPreferencesController < Api::Default::BaseController

  before_filter :find_profile, :only => [:update,:index]

  def index
    @child_profile = @profile.child_profiles.find(params[:child_id])
    @child_brewing_preferences = @child_profile.child_brewing_preference

    unless @child_brewing_preferences.nil?
      render json:{:status => true, :status_code=>6000,:message=>"Child brewing preference found",:temperature => @child_brewing_preferences.temperature, :milk=>@child_brewing_preferences.milk}
    else
      render json:{:status => false,:status_code=>6001, :message => "Child brewing preference not found for this id"}
    end
  end

  def update
    @child_profile = @profile.child_profiles.find(params[:child_id])
    @child_brewing_preference = @child_profile.child_brewing_preference
    params[:child_brewing_preference] = params[:brew_type] if params[:brew_type]
    params[:product_id] = params[:product_id] if params[:product_id]

    if @child_brewing_preference.update_attributes(params[:child_brewing_preference])
       render json:{:status => true,:status_code=>6002, :message => "Child brewing preference updated successfully"}
    else
       render json:{:status => false,:status_code=>6003, :message => "Child not found for this id"}
    end
  end

  private
  def find_profile
    @profile = ParentProfile.find(params[:profile_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :status_code=>3006, :message => "Unable to find parent profile on cloud"}
  end
end
