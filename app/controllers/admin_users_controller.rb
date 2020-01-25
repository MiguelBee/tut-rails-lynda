class AdminUsersController < ApplicationController
  before_action :confirm_logged_in

  layout "admin"

  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_params)
    if @admin_user.save
      flash[:notice] = "You have created a new Admin User"
      redirect_to admin_users_path
    else
      render "new"
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(admin_params)
      flash[:notice] = "User has been successfully updated"
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    @admin_user = AdminUser.find(params[:id])
    @admin_user.destroy
    flash[:notice] = "Admin User, #{@admin_user.full_name}, has been deleted"
    redirect_to admin_users_path
  end

private

  def admin_params
    params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
  end
end
