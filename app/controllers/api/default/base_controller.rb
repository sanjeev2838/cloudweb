class Api::Default::BaseController < ActionController::Base
  respond_to :json

  # for validating each api request with token stored in parent_profile
  def check_auth_token
    authtoken = request.headers['authtoken']
    profile_id = params[:profile_id]
    @profile = ParentProfile.find(profile_id)
    raise  if @profile.authtoken != authtoken
  rescue Exception => e
    render json:{:status => false,:status_code=> 4001, :message => "Auth token not verified"}
  end

end