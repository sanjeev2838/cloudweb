#todo Better to write jbuilder template later on
class Api::V1::ParentProfilesController < Api::V1::BaseController
  before_filter :find_profile, :only => [:update, :destroy]

  def create
    params[:parent_profile] = (params[:parent_profile]).merge(:status => true)
    @parent_profile = ParentProfile.create(params[:parent_profile])
    if @parent_profile.valid?
#      @profile['status'] = true
#       @api_value = @profile.to_json(:include => :machine,:root => true )
#       @api_value['status'] = false
#      render json:@profile.to_json(:include => :machine,:root => true )
#      format.json { render json:@parent_profile.to_json(:root => :true), status: :true}
      respond_to do |format|
        format.json { render action: :show}
      end
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