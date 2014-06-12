class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    debugger
    if params[:type] == 'profile'
      @user = ParentProfile.find_by_password_reset_token!(params[:id])
    else
      @user = User.find_by_password_reset_token!(params[:id])
    end
  end

  def update

    if params.has_key?('parent_profile')
      @user = ParentProfile.find_by_password_reset_token!(params[:id])
      user =  params[:parent_profile][:password]
    else
      @user = User.find_by_password_reset_token!(params[:id])
      user = params[:user][:password]
    end
    debugger
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(:password => user)
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end
