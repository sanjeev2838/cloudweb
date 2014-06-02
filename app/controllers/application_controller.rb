class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::RoutingError, :with => :render_not_found
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  include MachinesHelper
  include SessionsHelper
  include ApplicationHelper
  include ChildProfilesHelper

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render :template => "admin/dashboard/routing"
  end

  def verify_auth_token(authtoken)
    @profile = ParentProfile.find(params[:profile_id])
    raise  if @profile.authtoken != authtoken
  rescue Exception => e
    render json:{:status => false,:status_code=> 4001, :message => "Auth token not verified"}
  end

end
