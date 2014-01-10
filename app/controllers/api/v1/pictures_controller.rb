class Api::V1::PicturesController < Api::V1::BaseController

  def index
    @pictures = @child_profile.pictures
    if @pictures.empty?
      render json:{:status => false, :message => "Unable to find any picture for this profile"}
    end
  end

  def show
    @picture = @child_profile.pictures.find(params[:id])
    begin
      @logbook = Logbook.find(params[:id])
        # render json:@logbook.to_json
    rescue ActiveRecord::RecordNotFound
      render json:{:status => false, :message => "Unable to find picture_record on cloud"}
    end
  end

  def create
    @picture = @child_profile.pictures.create(params[:logbook])
    if @picture.valid?
      render json:{:status => true, :pictureid => @picture.id}
    else
      render json:{:status => false, :message => @picture.errors.full_messages }
    end
  end

  def destroy
    @picture = @child_profile.pictures.find(params[:id])
    if @picture.destroy
      render json:{:status => true}
    else
      render json:{:status => false, :message => "Unable to destroy parent profile on cloud"}
    end
  end

  private

  def find_child_profile
    @child_profile = ChildProfile.find(params[:children_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find child profile on cloud"}
  end
end
