class Api::V1::ChildStatsController < Api::V1::BaseController

  before_filter :find_profile, :only => [:update,:index,:create]
  # GET /child_stats
  # GET /child_stats.json
  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    @child_stats = @child_profile.child_stats

    unless @child_stats.nil?
      render json:{:status=>true ,:child_state=>@child_stats }
    else
      render json:{:status => false, :message => "Child stat not found "}
    end
  end
  #
  ## GET /child_stats/1
  ## GET /child_stats/1.json
  #def show
  #  @child_stat = ChildStat.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @child_stat }
  #  end
  #end
  #
  ## GET /child_stats/new
  ## GET /child_stats/new.json
  #def new
  #  @child_stat = ChildStat.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @child_stat }
  #  end
  #end
  #
  ## GET /child_stats/1/edit
  #def edit
  #  @child_stat = ChildStat.find(params[:id])
  #end
  #
  ## POST /child_stats
  ## POST /child_stats.json
  def create
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:child_id])
    vaccine = Vaccine.find_by_title(params[:vaccine])
    params[:child_stat] = params[:child_stat].merge(:vaccine_id => vaccine.id) unless vaccine.nil?
    @child_stat = @child_profile.child_stats.new(params[:child_stat])

    if @child_stat.save
      render json:{:status=>true ,:child_state=>@child_stat.to_json }
    else
      render json:{:status => false, :message => @child_stat.errors.full_messages}
    end

  end
  #
  ## PUT /child_stats/1
  ## PUT /child_stats/1.json
  #def update
  #  @child_stat = ChildStat.find(params[:id])
  #
  #  respond_to do |format|
  #    if @child_stat.update_attributes(params[:child_stat])
  #      format.html { redirect_to @child_stat, notice: 'Child stat was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @child_stat.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## DELETE /child_stats/1
  ## DELETE /child_stats/1.json
  #def destroy
  #  @child_stat = ChildStat.find(params[:id])
  #  @child_stat.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to child_stats_url }
  #    format.json { head :no_content }
  #  end
  #end
  private
  def find_profile
    @profile = ParentProfile.find(params[:profile_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find parent profile on cloud"}
  end
end
