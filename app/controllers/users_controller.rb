class UsersController < ApplicationController
  before_action :set_user
  
  def edit
  end

  def update
    @user.update_without_password(user_params)
    redirect_to root_path 
  end

  def mypage
  end
  
  private
  def set_user
    @user = current_user
  end
  
  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :age, :gender, :self_introduction, :image)
  end
end
