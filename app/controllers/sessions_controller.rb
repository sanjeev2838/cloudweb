class SessionsController < ApplicationController
  layout "devise"
  before_filter :user_logged_in ,only: [:new]
  def new

  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      user.update_attributes(:ip_address => request.remote_ip,:last_login=> Time.now)
      session[:current_user_id] = user.id
      sign_in user
      redirect_to admin_dashboard_index_path
    else
      flash[:notice]="Invalid user"
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end


  private
  def user_logged_in
    if current_user.present?
       redirect_to admin_dashboard_index_path , notice: "You are already logged in."
    end
  end
end
