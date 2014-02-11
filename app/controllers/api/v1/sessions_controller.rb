class Api::V1::SessionsController < Api::V1::BaseController


  def new

  end

  def create
    user = ParentProfile.find_by_email(params[:session][:email])
    I18n.locale = :en.to_sym
    unless user.nil?
      @machine = Machine.find(user.machine_id) unless user.machine_id.nil?
      I18n.locale = user.lang.to_sym
      if user.password == params[:session][:password]
        render json:{:status => true, :authtoken => user.authtoken, :profile=> user,:machine=> @machine}
      else
        render json:{:status => false, :message => I18n.t('login.password')}
      end
    else
      render json:{:status => false, :message => I18n.t('login.not_registered')}
    end
  end

  def destroy

  end

end