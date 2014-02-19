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
        unless user.tokenid.nil?
          user.update_attributes(:tokenid=>params[:tokenid])
        end
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

end