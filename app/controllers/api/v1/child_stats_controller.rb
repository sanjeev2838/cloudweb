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



  def child_vaccines
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    if params[:type].nil?
      render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}
      return
    end
    @vaccines = ChildStat.get_child_vaccine(@child_profile.id,@parent_profile.id,params[:type])
    if @vaccines.empty?
      render json:{:status => false, :message => "Child stats not found "}
    end

  end

  def child_meals
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    if params[:type].nil?
      render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}
      return
    end
    @meals = ChildStat.get_child_meals(@child_profile.id,@parent_profile.id,params[:type])
    if @meals.empty?
      render json:{:status => false, :message => "Child stats not found "}
    end

  end

  def child_diapers
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    if params[:type].nil?
      render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}
      return
    end
    @diapers = ChildStat.get_child_diapers(@child_profile.id,@parent_profile.id,params[:type])
    if @diapers.empty?
      render json:{:status => false, :message => "Child stats not found "}
    end
  end

  def child_full_bottles
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    if params[:type].nil?
      render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}
      return
    end
    @child_full_bottles = ChildStat.get_child_full_bottal(@child_profile.id,@parent_profile.id,params[:type])
    if @child_full_bottles.empty?
      render json:{:status => false, :message => "Child stats not found "}
    end
  end

  def child_half_bottles
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    if params[:type].nil?
      render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}
      return
    end
    @child_half_bottles = ChildStat.get_child_half_bottal(@child_profile.id,@parent_profile.id,params[:type])
    if @child_half_bottles.empty?
      render json:{:status => false, :message => "Child stats not found "}
    end
  end


  def create
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    vaccine = Vaccine.find_by_title(params[:vaccine])  if params[:vaccine]
    params[:child_stat] = params[:child_stat].merge(:vaccine_id => vaccine.id) unless vaccine.nil?
    params[:child_stat] = params[:child_stat].merge(:parent_profile_id => @parent_profile.id)
    @child_stat = @child_profile.child_stats.new(params[:child_stat])

    if @child_stat.save
      render json:{:status=>true ,:child_state=>@child_stat.as_json }
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
