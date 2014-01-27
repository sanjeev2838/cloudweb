class Api::V1::ChildStatsController < Api::V1::BaseController
  before_filter :verify_token

#todo remove parent_profile later on
  before_filter :find_profile, :only => [:update,:index,:create]

  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    @child_stats = @child_profile.child_stats
    @child_stats = get_child_stat(params[:type])

    unless @child_stats.nil?
      render json:{:status=>true ,:child_state=>@child_stats }
    else
      render json:{:status => false, :message => "Child stat not found "}
    end
  end

  def get_child_stat(type)
    #  time_range = 1.weeks.ago..Time.now
    case type
      when "daily"
        @child_profile.child_stats.where("created_at >= ?", 1.day.ago..Time.now)
      when "weekly"
        @child_profile.child_stats.where("created_at >= ?", 1.weeks.ago..Time.now)
      when "monthly"
        @child_profile.child_stats.where("created_at >= ?", 1.months.ago..Time.now)
      when "yearly"
        @child_profile.child_stats.where("created_at >= ?", 1.years.ago..Time.now)
      else
        @child_profile.child_stats
    end
  end

  def create
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    vaccine = Vaccine.find_by_title(params[:vaccine])  if params[:vaccine]
    params[:child_stat] = params[:child_stat].merge(:vaccine_id => vaccine.id) unless vaccine.nil?
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
    authtoken = request.headers['authtoken']
    @profile = ParentProfile.find(params[:profile_id])
    raise  if @profile.authtoken != authtoken
  rescue Exception => e
    render json:{:status => false, :message => "Auth token not verified"}
  end

end
