class Admin::UsersController < ApplicationController

  before_filter :admin?

  def index
    if current_user
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
      redirect_to admin_users_path, notice: "#{@user.full_name} created!"
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
      redirect_to admin_users_path, notice: "#{@user.full_name} updated!"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted"
  end

  def switch_account
    if sudo_user
      session[:user_id] = sudo_user.id
      session[:admin_id] = nil
      redirect_to admin_users_path
    else
      session[:admin_id] = current_user.id
      session[:user_id] = params[:id]
      redirect_to root_path
    end
  end

  private 

  def admin?
    unless current_user.admin || sudo_user.admin
      redirect_to root_path, notice: "nice try"
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end