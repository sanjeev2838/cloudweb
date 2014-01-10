class Api::V1::ChildStatsController < Api::V1::BaseController
  #before_filter :authorize_admin!, :except => [:index, :show]
  before_filter :find_profile, :only => [:show, :update, :destroy]

  def index
    @profiles = ParentProfile.all
    respond_with(@profiles)
  end

  def show
    respond_with @profile
  end

  def create
    profile = ParentProfile.create(params[:profile])
    if project.valid?
      respond_with(profile, :location => api_v1_parent_profile(profile))
    else
      respond_with(profile)
    end
  end

  def update
    @profile.update_attributes(params[:profile])
    respond_with(@profile)
  end

  def destroy
    @profile.destroy
    respond_with(@profile)
  end

  private

  def find_machine
    @profile = ParentProfile.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error = { :error => "The parent profile you were looking for could not be found."}
    respond_with(error, :status => 404)
  end

end