class Admin::UsersController < ApplicationController
  before_action :admin_require

  def index
    users = User.sort_by_name
    render locals: { users: users }
  end

  def update
    user = User.find(params[:id])
    user.update(admin: params.fetch(:user, {})[:admin])
    redirect_to admin_users_url
  end
end
