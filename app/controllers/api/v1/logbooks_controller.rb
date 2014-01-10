class Api::V1::LogbooksController <  Api::V1::BaseController
  before_filter :find_child_profile, :only => [:index, :show, :update,:destroy, :create]
  respond_to :json

  def index
    @log_books = @child_profile.logbooks
    if @log_books.empty?
      render json:{:status => false, :message => "Child not found for this id"}
    end
  end

  def show
    begin
     @logbook = Logbook.find(params[:id])
    # render json:@logbook.to_json
     rescue ActiveRecord::RecordNotFound
       render json:{:status => false, :message => "Unable to find log_record on cloud"}
     end
  end


  def create
    @log_book = @child_profile.logbooks.create(params[:logbook])
    if @log_book.valid?
      render json:{:status => true, :logid => @log_book.id}
    else
      render json:{:status => false, :message => @log_book.errors.full_messages }
    end
  end


  def update
    @log_book = @child_profile.logbooks.find(params[:id])
    if @log_book.update_attributes(params[:log_book])
      render json:{:status => true }
    else
      render json:{:status => false, :message => @log_book.errors.full_messages }
    end
  end
#
##TODO check api of this method with davinder
#  def destroy
#    render json:{:status => true}
#  end

  private

  def find_child_profile
    @child_profile = ChildProfile.find(params[:children_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find child profile on cloud"}
  end
end
