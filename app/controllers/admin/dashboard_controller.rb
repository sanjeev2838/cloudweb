class Admin::DashboardController < ApplicationController
  def index

  end

  def staff_users
    @users = User.all
  end
end
