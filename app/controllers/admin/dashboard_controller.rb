class Admin::DashboardController < ApplicationController

  def index
    @total_users = ParentProfile.all
    @total_childs = ChildProfile.all
    @total_registed_machines = Machine.where(:status=> true)
    @total_unregisted_machines = Machine.where(:status=> false)


  end

  def staff_users
    @users = User.all
  end
end
