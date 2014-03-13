class Api::V1::ChildProfilesController < Api::V1::BaseController
  before_filter :find_profile,:verify_token, :only => [:index,:show, :update,:destroy,:create]
  include TokenValidation

  def index
    @parents = ParentProfile.find_all_by_machine_id(@profile.machine_id)
    @child_profiles=[]
    @parents.each do |parent|
      parent.child_profiles.find_all_by_status(true).each do |child|
        unless child.nil?
          @child_profiles << child unless @child_profiles.include?(child)
        end
      end
    end
    @child_profiles = @child_profiles.sort! { |a,b| b[:created_at] <=> a[:created_at] }
    if @child_profiles.empty?
       render json:{:status => false,:status_code=>4003, :message => "Child not found for this id"}
    end
  end

#todo   BUT ABOUT THE STATUS HERE
  def show
    begin
     @child_profile = @profile.child_profiles.find(params[:id])
     @picture = @child_profile.pictures.all(:conditions => {:profilepic=>true}).first
    rescue ActiveRecord::RecordNotFound
      render json:{:status => false,:status_code=>4005, :message => "Unable to find child profile on cloud"}
    end
  end

  #http://stackoverflow.com/questions/845366/nested-object-creation-with-json-in-rails
  #If u feel something strange in the following loc because our  team lead wants exact naming
  # convention as in Api document he is written .
  # listening his developers.

  def create_picture(params)
    unless params[:picture].nil?
      #create a new tempfile named fileupload
      tempfile = Tempfile.new("fileupload")
      tempfile.binmode
      #get the file and decode it with base64 then write it to the tempfile
      tempfile.write(Base64.decode64(params[:picture]) )
      #create a new uploaded file
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename =>'image.png', :original_filename => 'old',:content_type=>"image/jpeg")
      #replace picture_path with the new uploaded file
      @picture = @child_profile.pictures.create(:image=>uploaded_file, :profilepic => true)
    end
  end

  def create
    @parents = ParentProfile.find_all_by_machine_id(@profile.machine_id)
    childes=[]
    @parents.each do |parent|
      unless parent.child_profiles.empty?
        childes << parent.child_profiles
      end
    end
    if childes.count >= 5
      render json:{:status => false, :message => "You can't add more child with this machine" }
    else
      params[:child_profile][:child_brewing_preference_attributes] = params[:preferences]
      params[:child_profile]= params[:child_profile].merge :status=>true
      @child_profile = @profile.child_profiles.create(params[:child_profile])
      create_picture(params)
      if @child_profile.valid?
        render action: :create
      else
        render json:{:status => false,:status_code=>4007, :message => @child_profile.errors.full_messages}
      end
    end
  end

  def update
    @child_profile = ChildProfile.find(params[:id])
    @picture = Picture.where(:child_profile_id => @child_profile.id).first
    @picture.destroy unless @picture.nil?
    create_picture(params)
    if @child_profile.update_attributes(params[:child_profile])
      render action: :create
    else
      render json:{:status => false,:status_code=>4008, :message => "Child not found for this id"}
    end

  end
  #
  def destroy
    #todo add exception handler here for wrong id
    @child_profile = ChildProfile.find(params[:id])
    if @child_profile.update_column(:status , false)
      render json:{:status => true,:status_code=>4009, :message => "Child Deleted successfully"}
    else
      render json:{:status => false,:status_code=>4010, :message => "Child not found for this id"}
    end

  end


  private
  def find_profile
    @profile = ParentProfile.find(params[:profile_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false,:status_code=>4000, :message => "Unable to find parent profile on cloud"}
  end

   # todo refector later on by migrating a helper method


  def verify_token
    check_auth_token(request.headers['authtoken'],params[:profile_id])
  end

end