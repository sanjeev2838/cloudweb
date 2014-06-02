class Api::V1::SessionsController < Api::V1::BaseController

  def new
  end

  def create
    user = ParentProfile.find_by_email_and_status(params[:session][:email],true)
    I18n.locale = :en.to_sym
    unless user.nil?
      @machine = Machine.find(user.machine_id) unless user.machine_id.nil?
      I18n.locale = user.lang.to_sym
      if user.password == params[:session][:password]
        user.update_attributes(:tokenid=>params[:tokenid])
        render json:{:status => true,:status_code=>7000,:message=>"Login successfull" ,:authtoken => user.authtoken, :profile=> user,:machine=> @machine}
      else
        render json:{:status => false,:status_code=>7001, :message => I18n.t('login.password')}
      end
    else
      render json:{:status => false, :status_code=>7002,:message => I18n.t('login.not_registered')}
    end
  end

  def destroy
  end

  def update
    email = ParentProfile.find_by_email(params[:session][:email])
    if email.nil?
      render json:{:status => false, :message => "User not found for this email"}
    else
      input = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      random_string = (0...10).map { input[rand(input.length)] }.join
      email.update_attributes(:password => random_string)
      @subject = "Password changed"
      @body =  "new password is #{random_string}"
      UserMailer.registration_confirmation(email,@subject,@body).deliver
      render json:{:status => true, :message => "Password changed successfully"}
    end

  end

end