class Api::V1::VaccinesController < Api::V1::BaseController

  def index
    @vaccines = Vaccine.where(status: true).order(:title)
    render json:{:status=>true ,:status_code=>8000,:message=> "vaccines found",:vaccines=>@vaccines }
  end

  def verify_token
    authtoken = request.headers['authtoken']
    @profile = ParentProfile.find(params[:profile_id])
    raise  if @profile.authtoken != authtoken
  rescue Exception =>e
    render json:{:status => false,:status_code=>8001, :message => "Auth token not verified"}
  end

end
