class UsersController < ApplicationController
  before_action :set_user
  
  def edit
  end

  def update
    if @user.update_without_password(user_params)
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages
      redirect_back(fallback_location: mypage_edit_users_path)
    end
  end

  def mypage
  end
  
  def update_password
    if password_set? && @user.update_password(user_params)
      flash[:notice] = "パスワードは正しく更新されました"
      redirect_to root_path
    else
      @user.errors.add(:password, "パスワードに不備があります")
      render "edit_password"
    end
  end
  
  def edit_password
  end
  
  def destroy
    @user.deleted_flg = User.switch_flg(@user.deleted_flg)
    @user.update(deleted_flg: @user.deleted_flg)
    redirect_to new_user_session_path
  end
  
  private
  def set_user
    @user = current_user
  end
  
  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :age, :gender, :self_introduction, :image, :instagram_url)
  end
  
  def password_set?
    user_params[:password].present? && user_params[:password_confirmation].present? ?
    true : false
  end
end
