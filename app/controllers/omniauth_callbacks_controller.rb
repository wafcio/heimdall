class OmniauthCallbacksController < ApplicationController
  def callback
    interactor = FindOmniauthUser.call(request.env["omniauth.auth"])
    session[:user_id] = interactor.user.id
    redirect_to root_url
  end

  def sign_out
    session[:user_id] = nil
    redirect_to root_url
  end
end
