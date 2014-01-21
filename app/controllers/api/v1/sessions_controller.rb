class Api::V1::SessionsController < Api::V1::BaseController


  def new

  end

  def create
    puts "the params are #{params}"
    user = ParentProfile.find_by_email(params[:session][:email])
    I18n.locale = user.lang.to_sym
    unless user.nil?
      if user.password == params[:session][:password]
        render json:{:status => true, :authcode => user.authtoken}
      else
        render json:{:status => false, :message => " Password not Matched"}
      end
    else
      render json:{:status => false, :message => "Email not Matched"}
    end
  end

  def destroy

  end

end