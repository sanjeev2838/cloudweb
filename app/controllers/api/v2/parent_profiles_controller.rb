class Api::V2::ParentProfilesController < Api::Default::BaseController
  before_filter :find_profile, :only => [:update, :destroy, :show]

  def create
    @machine  = Machine.where("serialid = ?", params[:parent_profile][:serialid]).first
    if @machine.nil?
      render json:{:status => false, :status_code=> 3001,:message => "Please specify registered machine id"}
      return
    end

    @parent_profile = ParentProfile.where(:email =>  params[:parent_profile][:email]).first
    if @parent_profile.nil?
      params[:parent_profile] = (params[:parent_profile]).merge(:status => true)
      @parent_profile = ParentProfile.new(params[:parent_profile])
      @parent_profile.profile_rank = @machine.parent_profiles.count + 1

      if @parent_profile.save
        render action: :create
      else
        render json:{:status => false, :status_code=> 3001,:message => @parent_profile.errors.full_messages}
      end
    else
      render json:{:status => false, :id => @parent_profile.id, :authtoken => @parent_profile.authtoken, :rank => @parent_profile.profile_rank , :status_code=> 3008,:message => "parent profile already exist for that Email address" }
    end

  end


  private
  def find_profile
    @parent_profile = ParentProfile.find(params[:id])
    raise  ActiveRecord::RecordNotFound if @parent_profile.nil?
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false,:status_code=>3006, :message => "Unable to find parent profile on cloud"}
  end

end
