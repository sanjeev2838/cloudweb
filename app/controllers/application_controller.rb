class ApplicationController < ActionController::Base
  protect_from_forgery
  include MachinesHelper
  include SessionsHelper

end
