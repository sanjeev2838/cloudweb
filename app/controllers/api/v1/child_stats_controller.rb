class Api::V1::ChildStatsController < Api::V1::BaseController

  before_filter :verify_token
  before_filter :find_child_profile, :only => [:index, :create, :child_meals, :child_vaccines,:child_half_bottles ,:child_full_bottles]

  def index
    render json:{:status => false, :message => 'qw'} if params[:type].nil?
    @stats = ChildStat.get_child_stat(@child_profile.id,@profile.id,params[:type])
    render json:{:status => false, :message => 'Child stats not found'}  if @stats.empty?
  end

  def child_vaccines
    render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}  if params[:type].nil?
    @vaccines = ChildStat.get_child_vaccine(@child_profile.id,@parent_profile.id,params[:type])
    render json:{:status => false, :message => "Child Vaccines not found "}  if @vaccines.empty?
  end

  def child_meals
    render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}  if params[:type].nil?
    @meals = ChildStat.get_child_meals(@child_profile.id,@profile.id,params[:type])
    render json:{:status => false, :message => "Child meals not found "} if @meals.empty?
  end

  def child_diapers
    render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}  if params[:type].nil?
    @diapers = ChildStat.get_child_diapers(@child_profle.id,@parent_profile.id,params[:type])
    render json:{:status => false, :message => "Child diapers not found "}  if @diapers.empty?
  end

  def child_full_bottles
    render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "}  if params[:type].nil?
    @child_full_bottles = ChildStat.get_child_bottle(@child_profile.id,@profile.id,params[:type],1)
    render json:{:status => false, :message => "Child full bottles not found "} if @child_full_bottles.empty?
  end

  def child_half_bottles
    render json:{:status => false, :message => "Please specify type: weekly, monthly in parameters "} if params[:type].nil?
    @child_half_bottles = ChildStat.get_child_bottle(@child_profile.id,@profile.id,params[:type],2)
    render json:{:status => false, :message => "Child half bottles not found "} if @child_half_bottles.empty?
  end

  def create
    params[:child_stat] = params[:child_stat].merge(:vaccine_id => params[:vaccine])
    params[:child_stat] = params[:child_stat].merge(:parent_profile_id => @profile.id)
    @child_stat = @child_profile.child_stats.new(params[:child_stat])
    if @child_stat.save
      render json:{:status=>true ,:child_state=>@child_stat.as_json }
    else
      render json:{:status => false, :message => @child_stat.errors.full_messages}
    end
  end

  private

  def find_child_profile
    begin
      @profile = ParentProfile.find(params[:profile_id])
      @child_profile = @profile.child_profiles.find(params[:child_id])
    rescue ActiveRecord::RecordNotFound
      render json:{:status => false, :message => "Unable to find child profile on cloud"}
      return  false
    end
  end

  #def child_profile_id
  #  begin
  #
  #  rescue ActiveRecord::RecordNotFound
  #    render json:{:status => false, :message => "Unable to find child profile on cloud"}
  #    return
  #  end
  #end

  def verify_token
  #  authtoken = request.headers['authtoken']
  #  @profile = ParentProfile.find(params[:profile_id])
  #  raise  if @profile.authtoken != authtoken
  #rescue Exception => e
  #  render json:{:status => false, :message => "Auth token not verified"}
  end

end
