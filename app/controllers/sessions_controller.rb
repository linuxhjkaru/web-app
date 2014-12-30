class SessionsController < ApplicationController
  def callback
    json = request.env["omniauth.auth"].to_json
    auth = JSON.parse json
    binding.pry
    svs  = current_user.profile.services.send(params[:provider])
    svs.set_auth auth
    svs.save
    redirect_to edit_user_path(current_user)
  end
end
