#todo Better to write jbuilder template later on
class Api::V1::ParentProfilesController < Api::V1::BaseController
  before_filter :find_profile, :only => [:update, :destroy, :show]
  before_filter :verify_token , :only => [:update,:destroy, :show]

# if you see strange view names it is because of our team_lead
  def show
    render json:{:status => true, :status_code=>3007,:message=>"parent profile found",profile: @parent_profile }
  end

  def create
    params[:parent_profile] = (params[:parent_profile]).merge(:status => true)
    object= ParentProfile.where(:tokenid => params[:tokenid])
    unless object.nil?
      object.each do |obj|
        obj.update_attributes(:tokenid=>"")
      end
    end
    @parent_profile = ParentProfile.create(params[:parent_profile])
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

  def verify_token
  #  authtoken = request.headers['authtoken']
  #  @parent_profile = ParentProfile.find(params[:id])
  #  raise  if @parent_profile.authtoken != authtoken
  #rescue Exception => e
  #  render json:{:status => false, :message => "Auth token not verified"}
  end

end