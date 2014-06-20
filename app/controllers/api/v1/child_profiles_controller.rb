class Api::V1::ChildProfilesController < Api::V1::BaseController
  before_filter :find_profile

  def index
    @child_profiles = get_all_children_of_all_parents_on_machine
    if @child_profiles.empty?
       render json:{:status => false,:status_code=>4003, :message => "Child not found for this id"}
    else
      @child_profiles = @child_profiles.sort! { |a,b| b[:created_at] <=> a[:created_at] }
    end
  end

  def show
    begin
     @child_profile = ChildProfile.find(params[:id])
     @picture = @child_profile.pictures.where(:profilepic => true).first
    rescue ActiveRecord::RecordNotFound
      render json:{:status => false,:status_code=>4005, :message => "Unable to find child profile on cloud"}
    end
  end

  def create
    @child_profiles = get_all_children_of_all_parents_on_machine
    if @child_profiles.count >= 5
      render json:{:status => false, :message => "You can't add more child with this machine" }
    else
      params[:child_profile]= params[:child_profile].merge :status=>true
      @child_profile = @profile.child_profiles.new(params[:child_profile])
      if @child_profile.save
        @picture =  create_picture(params[:picture]) unless params[:picture].nil?
        render action: :create
      else
        render json:{:status => false,:status_code=>4007, :message => @child_profile.errors.full_messages}
      end
    end
  end

 def update
    @child_profile = ChildProfile.find(params[:id])
    if @child_profile.update_attributes(params[:child_profile])
      @picture = create_picture(params[:picture]) unless params[:picture].nil?
      render action: :create
    else
      render json:{:status => false,:status_code=>4008, :message => "Child not found for this id"}
    end
  end

   def destroy
     @child_profile = ChildProfile.find(params[:id])
     if @child_profile.update_column(:status , false)
       render json:{:status => true,:status_code=>4009, :message => "Child Deleted successfully"}
     else
       render json:{:status => false,:status_code=>4010, :message => "Child not found for this id"}
     end
   end

   def email_diary_records
     @dairy = Diary.find_all_by_child_profile_id(params[:id])
     @email_id =  @profile.email
     UserMailer.send_pdf(@dairy, @email_id).deliver
     render json:{:status => true }
   end

   def get_pdf
     @dairy = Diary.find_all_by_child_profile_id(params[:id])
     @email_id =  @profile.email
     respond_to do |format|
       format.pdf do
         render :pdf => "mypdf",
                :template => "/api/v1/child_profiles/get_pdf.pdf.erb" ,
                :page_height => '2in', :page_width => '2in'
         end
     end
   end

   private
   def find_profile
     @profile = ParentProfile.find(params[:profile_id])
   rescue ActiveRecord::RecordNotFound
     render json:{:status => false,:status_code=>4000, :message => "Unable to find parent profile on cloud"}
   end

   def get_all_children(parents)
     child_profiles = []
     parents.each do |parent|
       parent.child_profiles.find_all_by_status(true).each do |child|
         unless child.nil?
           child_profiles << child unless child_profiles.include?(child)
         end
       end
     end
     child_profiles
   end

   def get_all_children_of_all_parents_on_machine
     parents = ParentProfile.find_all_by_machine_id(@profile.machine_id)
     child_profiles = get_all_children(parents)
   end

   def image_action_dispatch_object(picture)
     tempfile = Tempfile.new("fileupload")
     tempfile.binmode
     tempfile.write(Base64.decode64(picture) )
     uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename =>'image.png', :original_filename => 'old',:content_type=>"image/jpeg")
   end

   def create_picture(picture)
       uploaded_file =  image_action_dispatch_object(picture)
       @child_profile.pictures.create(:image=>uploaded_file, :profilepic => true)
   end

end
