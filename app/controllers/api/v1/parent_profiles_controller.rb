#todo Better to write jbuilder template later on
class Api::V1::ParentProfilesController < Api::V1::BaseController
  before_filter :find_profile, :only => [:update, :destroy, :show]
  before_filter :verify_token , :only => [:update,:destroy, :show]
  include TokenValidation

  def show
    render json:{:status => true, :status_code=>3007,:message=>"parent profile found",profile: @parent_profile }
  end

  def create
    @parent_profile = ParentProfile.where(:email =>  params[:parent_profile][:email]).first
    if @parent_profile.nil?
      params[:parent_profile] = (params[:parent_profile]).merge(:status => true)
      @parent_profile = ParentProfile.create(params[:parent_profile])
    else
      @parent_profile.status = true
      @parent_profile.save!
    end

    if @parent_profile.valid?
         render action: :create
    else
      render json:{:status => false, :status_code=>3001,:message => @parent_profile.errors.full_messages}
    end
  end

  def update
    if @parent_profile.update_attributes(params[:parent_profile])
      render action: :update
    else
      render json:{:status => false,:status_code=>3003, :message => @parent_profile.errors.full_messages }
    end
  end

  def destroy
    if @parent_profile.update_column(:status , false)
      render json:{:status => true,:status_code=>3004,:message=>"Profile deleted successfully"}
    else
      render json:{:status => false, :status_code=>3005,:message => "Unable to destroy parent profile on cloud"}
    end
  end

  private
  def find_profile
    @parent_profile = ParentProfile.find(params[:id])
    raise  ActiveRecord::RecordNotFound if @parent_profile.nil?
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false,:status_code=>3006, :message => "Unable to find parent profile on cloud"}
  end

  #def verify_token
  #  check_auth_token(request.headers['authtoken'],params[:profile_id])
  #end

end