require 'digest/md5'

class Api::V1::SessionsController < Api::Default::BaseController
  protect_from_forgery :except => :update
  def new
  end

  def create
    user = ParentProfile.find_by_email_and_status(params[:session][:email],true)
    I18n.locale = :en.to_sym
    if user 
      cookies[:auth_token] = user.authtoken
      @machine = Machine.find(user.machine_id) unless user.machine_id.nil?
      I18n.locale = user.lang.to_sym
      if @machine.id != user.machine_id
        render json:{:status => false,:status_code=>7000,:message=>"You cant login on this machine" }
      else
        if user.password == Digest::MD5.hexdigest(params[:session][:password])
          render json:{:status => true,:status_code=>7000,:message=>"Login successful" ,:authtoken => user.authtoken, :profile=> user,:machine=> @machine}
        else
          render json:{:status => false,:status_code=>7001, :message => I18n.t('login.password')}
        end
      end
    else
      render json:{:status => false,:status_code=>7002, :message => "user with this email not registered" }
    end

  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Logged out!"
  end

  #todo change name of this method later on
  def update
      parent_profile = ParentProfile.find_by_email(params[:email])
      parent_profile.send_password_reset if parent_profile
      render json:{:status => true, :message => "Email sent with password reset instructions."}
  end

end
