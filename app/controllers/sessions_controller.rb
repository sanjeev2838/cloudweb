class SessionsController < ApplicationController
  layout "devise"
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      user.update_attributes(:ip_address => request.remote_ip,:last_login=> Time.now)
      sign_in user

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
