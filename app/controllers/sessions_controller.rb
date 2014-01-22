class SessionsController < ApplicationController
  layout "devise"
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])

      redirect_to admin_dashboard_index_path
    else
      # Create an error message and re-render the signin form.
    end
  end

  def destroy
  end
end
