class Admin::UsersController < ApplicationController
  def index
    if current_user && current_user.admin
      @users = User.all
    else
      # flash[:notice] = "You are not an admin"
      redirect_to root_path, alert: "You are not an admin"
    end
  end
end