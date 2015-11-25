class Admin::UsersController < ApplicationController
  def index
    if current_user && current_user.admin
      @users = User.all.page(params[:page]).per(10)
    else
      # flash[:notice] = "You are not an admin"
      redirect_to root_path, alert: "You are not an admin"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.firstname} #{@user.lastname} created!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "#{@user.firstname} #{@user.lastname} updated!"
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end