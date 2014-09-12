class Api::V1::MilestonesController <  Api::Default::BaseController

  def index
    @milestones = Milestone.all
    if @milestones.empty?
      render json:{:status => false, :message => "No milestones found"}
    end
  end

end
