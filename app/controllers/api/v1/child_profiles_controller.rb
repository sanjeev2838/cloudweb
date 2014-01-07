class Api::V1::ChildProfilesController < Api::V1::BaseController
  #before_filter :authorize_admin!, :except => [:index, :show]
  before_filter :find_profile, :only => [:show, :update, :destroy]

  def index
    @parent_profile = ParentProfile.find(params[:profile_id])
    @parent_profile.child_profiles
    #@child_profile = @.comments.create(params[:comment])
    #redirect_to post_path(@post)
  end

  #def show
  #  respond_with @profile
  #end

  #http://stackoverflow.com/questions/845366/nested-object-creation-with-json-in-rails
  #If u feel something strange in the following loc bec team lead wants exact naming
  # convention as in Api document he is written .
  # listening his developers.

  def create
    @parent_profile = ParentProfile.find(params[:profile_id])

    params[:child_profile][:child_brewing_preferences_attributes] = params[:preferences]
    @child_profile = @parent_profile.child_profiles.create(params[:children])
    if @child_profile.valid?
      render json:{:status => true, :child_id => @child_profile.id}
    else
      render json:{:status => false, :message => @child_profile.errors.full_messages}
    end
  end
  #
  #def update
  #  @profile.update_attributes(params[:profile])
  #  respond_with(@profile)
  #end
  #
  #def destroy
  #  @profile.destroy
  #  respond_with(@profile)
  #end
  #
  #private
  #
  #def find_machine
  #  @profile = ChildProfile.find(params[:id])
  #rescue ActiveRecord::RecordNotFound
  #  error = { :error => "The parent profile you were looking for could not be found."}
  #  respond_with(error, :status => 404)
  #end

end