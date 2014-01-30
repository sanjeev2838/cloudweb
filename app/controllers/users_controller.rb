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
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'Stafff User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
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
