class Api::V1::SessionsController < Api::V1::BaseController
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
        if user.password == params[:session][:password]
          render json:{:status => true,:status_code=>7000,:message=>"Login successfull" ,:authtoken => user.authtoken, :profile=> user,:machine=> @machine}
        else
          render json:{:status => false,:status_code=>7001, :message => I18n.t('login.password')}
        end
      end
    else
      render json:{:status => false,:status_code=>7002, :message => "user with this email not registered" }
    end

    #user = ParentProfile.find_by_email_and_status(params[:session][:email],true)
    #I18n.locale = :en.to_sym
    #if user
    #  @machine = Machine.find(user.machine_id) unless user.machine_id.nil?
    #  I18n.locale = user.lang.to_sym
    #  if @machine.id != user.machine_id
    #    render json:{:status => false,:status_code=>7000,:message=>"You cant login on this machine" }
    #  else
    #    if user.password == params[:session][:password]
    #      render json:{:status => true,:status_code=>7000,:message=>"Login successfull" ,:authtoken => user.authtoken, :profile=> user,:machine=> @machine}
    #    else
    #      render json:{:status => false,:status_code=>7001, :message => I18n.t('login.password')}
    #    end
    #  end
    #
    #else
    #  render json:{:status => false, :status_code=>7002,:message => I18n.t('login.not_registered')}
    #end
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


    #email = ParentProfile.find_by_email(params[:session][:email])
    #if email.nil?
    #  render json:{:status => false, :message => "User not found for this email"}
    #else
    #  input = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    #  random_string = (0...10).map { input[rand(input.length)] }.join
    #  email.update_attributes(:password => random_string)
    #  @subject = "Password changed"
    #  @body =  "new password is #{random_string}"
    #  UserMailer.registration_confirmation(email,@subject,@body).deliver

  end
end
