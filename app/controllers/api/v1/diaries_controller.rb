class Api::V1::DiariesController < Api::V1::BaseController
  before_filter :find_child_profile, :only => [:index, :show, :update,:destroy, :create]
  include DiariesHelper

  def index
    @diaries = @child_profile.diaries
    if @diaries.empty?
      render json:{:status => false, :message => "Child not found for this id"}
    end
  end

  def show
    begin
      @diary = Diary.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json:{:status => false, :message => "Unable to find log_record on cloud"}
    end
  end

  def create
    @diary = @child_profile.diaries.create(:log=>params[:log])
    milestones = params[:milestone]
    if milestones.kind_of?(Array)
      milestones.each do |milestone_id|
        obj = Milestone.find_by_id(milestone_id)
        @diary.milestones << obj
      end
    end
    files_count = params[:filescount].to_i
    create_pictures(params,@diary) if files_count > 0
    if @diary
      render json:{:status => true, :logid => @diary.id}
    else
      render json:{:status => false, :message => @diary.errors.full_messages }
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    if @diary.destroy
      render json:{:status => true}
    else
      render json:{:status => false, :message => "Unable to destroy diary on cloud"}
    end
  end

  def create_pictures(params,diary)
    files_count = params[:filescount].to_i
    for i in 1..files_count
      file = params["image#{i}"]
      unless file.nil?
        tempfile = Tempfile.new("fileupload")
        tempfile.binmode
        tempfile.write(Base64.decode64(file))
        uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename =>"image#{i}.png", :original_filename => 'old',:content_type=>"image/jpeg")
        @picture = diary.pictures.create(:image=>uploaded_file,:child_profile_id=>@child_profile.id)
        #todo add validation if unable to create picture record
        #todo return picture id hash for updation of each picture
      end
    end
  end

  private

  def find_child_profile
    @child_profile = ChildProfile.find(params[:children_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find child profile on cloud"}
  end

  #def verify_token
  #  authtoken = request.headers['authtoken']
  #  @parent_profile = ParentProfile.find(params[:profile_id])
  #  raise  if @parent_profile.authtoken != authtoken
  #rescue Exception => e
  #  render json:{:status => false, :message => "Auth token not verified"}
  #end

end
