class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy,:new]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy,:new,:update,:edit]
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    if @user.save
      redirect_to admin_dashboard_index_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:admin)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    unless current_user.admin?
      redirect_to admin_dashboard_index_path,notice: "You are not authorize to perform this action"
    end
  end
end
