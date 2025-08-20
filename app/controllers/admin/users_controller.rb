class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @users = current_user.organisation.users
  end

  def new
    @user = User.new
  end

  def create
    @user = current_user.organisation.users.new(user_params)
    @user.role = "reporter"
    @user.password = "changeme123"
    @user.password_confirmation = "changeme123"


    if @user.save
      redirect_to admin_users_path, notice: "Reporter user created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def require_admin!
    redirect_to root_path, alert: "Access denied." unless current_user.admin?
  end
end
