class Dashboard::UsersController < ApplicationController
  before_action :set_user, only: %w[edit update destroy]
  before_action :check_user_authority
  layout "dashboard/dashboard"
  PER = 15
  
  def index
    if params[:keyword].present?
      @keyword = params[:keyword].strip
      @users = User.search_information(@keyword).page(params[:page]).per(PER)
    else
      @users = User.page(params[:page]).per(PER)
    end
  end
  
  def destroy
    deleted_flg = User.switch_flg(@user.deleted_flg)
    @user.update(deleted_flg: deleted_flg)
    redirect_to dashboard_users_path
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user.update(user_params)
    redirect_to dashboard_users_path
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.permit(:authority)
  end
  
  def check_user_authority
		@user = current_user
		if @user.authority.eql?("2")
			flash[:alert] = "権限がありません"
			redirect_to dashboard_path 
		end
  end
end
