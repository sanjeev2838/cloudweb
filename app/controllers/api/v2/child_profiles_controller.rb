class Api::V2::ChildProfilesController < Api::Default::BaseController
  before_filter :find_profile

  # because as per new Logic there is always one child per ParentProfile
  def create
    @child_profile = @profile.child_profiles.first
    if @child_profile
      render action: :create
    else
      params[:child_profile][:child_brewing_preference_attributes] = params[:preferences]
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

   private
   def find_profile
     @profile = ParentProfile.find(params[:profile_id])
   rescue ActiveRecord::RecordNotFound
     render json:{:status => false,:status_code=>4000, :message => "Unable to find parent profile on cloud"}
   end

end
