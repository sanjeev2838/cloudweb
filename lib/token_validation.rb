module TokenValidation

  def check_auth_token(auth_token,profile_id)
    @profile = ParentProfile.find(profile_id)
    raise  if @profile.authtoken != auth_token
      rescue Exception =>e
        render json:{:status => false,:status_code=> 4001, :message => "Auth token not verified"}
  end
end