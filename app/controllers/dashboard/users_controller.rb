class Dashboard::UsersController < ApplicationController
  layout "dashboard/dashboard"
  
  def index
    if params[:keyword].present?
      @keyword = params[:keyword].strip
      @users = User.search_information(@keyword).all
    else
      @users = User.all
    end
  end
  
  def destroy
    user = User.find(params[:id])
    deleted_flg = User.switch_flg(user.deleted_flg)
    user.update(deleted_flg: deleted_flg)
    redirect_to dashboard_users_path
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to dashboard_users_path
  end
  
  private
  def user_params
    # params.require(:user).permit(:authority)
    params.permit(:authority)
  end
end
