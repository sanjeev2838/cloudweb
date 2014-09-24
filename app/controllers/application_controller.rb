class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::RoutingError do |e|
    render_not_found(e)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render_not_found(e)
  end

  include MachinesHelper
  include SessionsHelper
  include ApplicationHelper
  include ChildProfilesHelper

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  # in order to handle error  related to Api wrong path names
  def render_not_found(e)
    if env["ORIGINAL_FULLPATH"] =~ /^\/api/
      error_info = {
          :error => "internal-server-error",
          :exception => "#{e.class.name} : #{e.message}",
      }
      error_info[:trace] = e.backtrace[0,10] if Rails.env.development?
      render :json => error_info.to_json, :status => 500
    else
      render :template => "admin/dashboard/routing"
    end
  end

  def verify_auth_token(authtoken)
    @profile = ParentProfile.find(params[:profile_id])
    raise  if @profile.authtoken != authtoken
  rescue Exception => e
    render json:{:status => false,:status_code=> 4001, :message => "Auth token not verified"}
  end

end
