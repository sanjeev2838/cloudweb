class Api::V1::ParentProfilesController < Api::V1::BaseController
  #before_filter :authorize_admin!, :except => [:index, :show]
  before_filter :find_profile, :only => [:update, :destroy]

  #def index
  #  @profiles = ParentProfile.all
  #  respond_with(@profiles)
  #end

  #def show
  #  respond_with @profile
  #end

  #curl -X POST -H "Content-type: application/json" -d '{"created_at":"2013-12-26T11:28:42Z",i":"2432432","is_machine_owner":true,"machine_serial_id":324242141,"name":"rahul","status":true,"token_id":"2342343","updated_at":"2013-12-26T11:28:42Z"}'  http://localhost:3000/api/v1/profiles
   def create
    profile = ParentProfile.create!(params[:parent_profile])
    if profile.valid?
      render json:profile.to_json(:include => :machine )
    else
      render json:{:status => false, :message => "Unable to create new parent profile on cloud"}
    end
  end

  def update
    @profile.update_attributes(params[:profile])
    if @profile.valid?
      render json:@profile.to_json(:include => :machine )
    else
      render json:{:status => false, :message => "Unable to create new parent profile on cloud"}
    end
  end

  # curl -X DELETE  http://localhost:3000/api/v1/profiles/12
  def destroy
    @profile.destroy
    if @profile.destroy
      render json:{:status => true}
    else
      render json:{:status => false, :message => "Unable to delete profile on cloud"}
    end
  end

  private

  def find_profile
    @profile = ParentProfile.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error = { :error => "The parent profile you were looking for could not be found."}
    respond_with(error, :status => 404)
  end

end