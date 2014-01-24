class SessionsController < ApplicationController
  layout "devise"
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
       sign_in user
       #current_user user
      redirect_to admin_dashboard_index_path
    else
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
