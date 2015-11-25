class Admin::UsersController < ApplicationController
  def index
    if current_user && current_user.admin
      @users = User.all
    else
      # restrict_access
      redirect_to root_path, notice: "You are not an admin"
    end
  end
end