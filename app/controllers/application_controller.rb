class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authentication
    redirect_to root_url unless current_user
  end

  def admin_require
    redirect_to root_url if current_user.nil? || !current_user.admin?
  end
end
