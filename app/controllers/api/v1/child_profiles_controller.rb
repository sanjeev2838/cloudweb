class Api::V1::ChildProfilesController < Api::V1::BaseController
  before_filter :find_profile, :only => [:index,:show, :update,:destroy]

  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @child_profiles=@parent_profile.child_profiles
    unless @child_profiles.empty?
      render json:{:status => true, :children => @child_profiles}
    else
      render json:{:status => false, :message => "Child not found for this id"}
    end
  end

#todo   BUT ABOUT THE STATUS HERE
  def show
    begin
     @parent_profile = ParentProfile.find(params[:profile_id])
     @child_profile = @parent_profile.child_profiles.find(params[:id])
      render json:@child_profile.to_json(:include => :pictures )
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
    params[:child_profile][:picture] = "/9j/4AAQSkZJRgABAQAAAQABAAD/4QBoRXhpZgAASUkqAAgAAAADABIBAwABAAAAAQAAADEBAgAQAAAAMgAAAGmHBAABAAAAQgAAAAAAAABTaG90d2VsbCAwLjEyLjMAAgACoAkAAQAAAIAAAAADoAkAAQAAAIAAAAAAAAAA/+EJ3Wh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8APD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNC40LjAtRXhpdjIiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iIGV4aWY6UGl4ZWxYRGltZW5zaW9uPSIxMjgiIGV4aWY6UGl4ZWxZRGltZW5zaW9uPSIxMjgiIHRpZmY6SW1hZ2VXaWR0aD0iMSIgdGlmZjpJbWFnZUhlaWdodD0iMTI4Ii8+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPD94cGFja2V0IGVuZD0idyI/Pv/bAEMAAwICAwICAwMDAwQDAwQFCAUFBAQFCgcHBggMCgwMCwoLCw0OEhANDhEO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"
    #convert_from_base64(params[:child_profile][:picture])
    #----------------picture upload----------------
        #create a new tempfile named fileupload
    tempfile = Tempfile.new("fileupload")
    tempfile.binmode
        #get the file and decode it with base64 then write it to the tempfile
    tempfile.write(Base64.decode64(params[:child_profile][:picture]) )

        #create a new uploaded file
    uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename =>'new', :original_filename => 'old',:content_type=>"image/jpeg")
        #replace picture_path with the new uploaded file
    #params[:picture][:image] =  uploaded_file


    @picture = @child_profile.pictures.create(:image=>uploaded_file)
    #----------------------------------------------------------------------
    if @child_profile.valid?
      render json:{:status => true, :child_id => @child_profile.id}
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


  private
  def find_profile
    @profile = ParentProfile.find(params[:profile_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find parent profile on cloud"}
  end

end