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

  def create
    profile = ParentProfile.create(params[:parent_profile])
    if profile.valid?
      render json:profile.to_json(:include => :machine )
    else
      render json:{:status => false, :message => profile.errors.full_messages}
    end
  end

  def update
    if @profile.update_attributes(params[:parent_profile])
      render json:@profile.to_json(:include => :machine )
    else
      render json:{:status => false, :message => @profile.errors.full_messages }
    end
  end

  # curl -X DELETE  http://localhost:3000/api/v1/profiles/12
  def destroy
    if @profile.update_column(:status , false)
      render json:{:status => true}
    else
      render json:{:status => false, :message => "Unable to destroy parent profile on cloud"}
    end
  end

  private

  def find_profile
    @profile = ParentProfile.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find parent profile on cloud"}
  end

end