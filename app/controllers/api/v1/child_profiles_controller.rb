class Api::V1::ChildProfilesController < Api::V1::BaseController
  before_filter :find_profile,:verify_token, :only => [:index,:show, :update,:destroy,:create]

  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profiles=@parent_profile.child_profiles

    if @child_profiles.empty?
       render json:{:status => false, :message => "Child not found for this id"}
    end
  end

#todo   BUT ABOUT THE STATUS HERE
  def show
    begin
     @parent_profile = ParentProfile.find(params[:profile_id])
     @child_profile = @parent_profile.child_profiles.find(params[:id])
     @pictue = @child_profile.pictures.find(:conditions => {:profilepic=>true})
    rescue ActiveRecord::RecordNotFound
      render json:{:status => false, :message => "Unable to find parent profile on cloud"}
    end
  end

  #http://stackoverflow.com/questions/845366/nested-object-creation-with-json-in-rails
  #If u feel something strange in the following loc bec team lead wants exact naming
  # convention as in Api document he is written .
  # listening his developers.

  def create
    @parent_profile = ParentProfile.find(params[:profile_id])

    params[:child_profile][:child_brewing_preference_attributes] = params[:preferences]
    params[:child_profile]=params[:child_profile].merge :status=>true
    @child_profile = @parent_profile.child_profiles.create(params[:child_profile])
    unless params[:picture].nil?
      #----------------picture upload----------------
          #create a new tempfile named fileupload
      tempfile = Tempfile.new("fileupload")
      tempfile.binmode
        #get the file and decode it with base64 then write it to the tempfile
      tempfile.write(Base64.decode64(params[:picture]) )

        #create a new uploaded file
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename =>'image.png', :original_filename => 'old',:content_type=>"image/jpeg")
        #replace picture_path with the new uploaded file
      #params[:picture][:image] =  uploaded_file


      @picture = @child_profile.pictures.create(:image=>uploaded_file, :profilepic => true)
    end
    #----------------------------------------------------------------------
    if @child_profile.valid?
      render action: :create
      #render json:{:status => true, :child_id => @child_profile.id,:picture=>@picture.image.path }
    else
      render json:{:status => false, :message => @child_profile.errors.full_messages}
    end
  end
  #

  def update
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:id])

    if @child_profile.update_attributes(params[:child_profile])
      #@child_profile.update_column(:status , false)
      render json:{:status => true, :message => "Child updated successfully"}
    else
      render json:{:status => false, :message => "Child not found for this id"}
    end
    #render json:{:status => true, :message => "Child Deleted successfully"}
    #@profile.update_attributes(params[:profile])
    #respond_with(@profile)
  end
  #
  def destroy
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profile = @parent_profile.child_profiles.find(params[:id])
    if @child_profile.update_column(:status , false)
      #@child_profile.update_column(:status , false)
      render json:{:status => true, :message => "Child Deleted successfully"}
    else
      render json:{:status => false, :message => "Child not found for this id"}
    end

  end

  def get_vaccines
    #todo result based on type parameter
  end

  def get_meals
    #todo result based on type parameter

  end

  def get_half_booltes

  end

  def get_full_bottle_entries

  end

  def get_diapers

  end

  private
  def find_profile
    @profile = ParentProfile.find(params[:profile_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find parent profile on cloud"}
  end

   # todo refector later on by migrating a helper method

  def verify_token
    authtoken = request.headers['authtoken']
    @profile = ParentProfile.find(params[:profile_id])
    raise  if @profile.authtoken != authtoken
  rescue Exception =>e
    render json:{:status => false, :message => "Auth token not verified"}
  end

end