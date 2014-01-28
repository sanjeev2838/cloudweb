class Api::V1::ChildStatsController < Api::V1::BaseController
  before_filter :verify_token

#todo remove parent_profile later on
  before_filter :find_profile, :only => [:update,:index,:create]

  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    if params[:type].nil?
      render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}
      return
    end
    @stats = ChildStat.get_child_stat(@child_profile.id,@parent_profile.id,params[:type])
    if @stats.empty?
      render json:{:status => false, :message => "Child stats not found "}
    end
  end


  def create
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    vaccine = Vaccine.find_by_title(params[:vaccine])  if params[:vaccine]
    params[:child_stat] = params[:child_stat].merge(:vaccine_id => vaccine.id) unless vaccine.nil?
   # params[:child_stat] = params[:child_stat].merge(:)
    @child_stat = @child_profile.child_stats.new(params[:child_stat])

    if @child_stat.save
      render json:{:status=>true ,:child_stat => @child_stat.to_json }
    else
      render json:{:status => false, :message => @child_stat.errors.full_messages}
    end

  end

  private

  def find_profile
    @profile = ParentProfile.find(params[:profile_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find parent profile on cloud"}
  end

  def verify_token
  #  authtoken = request.headers['authtoken']
  #  @profile = ParentProfile.find(params[:profile_id])
  #  raise  if @profile.authtoken != authtoken
  #rescue Exception => e
  #  render json:{:status => false, :message => "Auth token not verified"}
  end

end
