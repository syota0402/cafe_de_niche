class UsersController < ApplicationController
  before_action :set_user, except: :show
  PER = 15
  
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
    reset_session
    redirect_to root_path
  end
  
  def show
    @show_user = User.find_by(id: params[:id])
    @followers = @show_user.followers(User)
    reviews = Review.where(user_id: params[:id]).order("created_at DESC")
    @reviews_count = reviews.count
    @reviews = reviews.page(params[:page]).per(PER)
    @user_best_shop = CoffeeShop.find_by(id: @show_user.best_shop_id)
  end
  
  def favorite
    @favorites = @user.likees(CoffeeShop)
  end

  def follow
    @follow_user = User.find_by(id: params[:id])
    current_user.toggle_follow!(@follow_user)
    if params[:target_action] = "show"
      redirect_to user_path(@follow_user.id)
    elsif params[:target_action] = "following"
      redirect_to following_users_path
    end
  end
  
  def following
    @follow_users = @user.followees(User)
  end
  
  def follower 
    @follower = @user.followers(User)
  end
  
  def setbestshop
    @coffee_shop = CoffeeShop.find_by(id: params[:id])
    set_best_shop
    @user.update(best_shop_id: @set_best_shop_id)
    redirect_to coffee_shop_path(@coffee_shop.id)
  end
  
  private
  def set_user
    @user = current_user
  end
  
  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :age, :gender, :self_introduction, :image, :instagram_url, :twitter_url, :youtube_url, :users_blog_url, :tabelog_url, :facebook_url, :tiktok_url)
  end
  
  def password_set?
    user_params[:password].present? && user_params[:password_confirmation].present? ? true : false
  end
  
  def set_best_shop
    # 同じなら解除
    if @user.best_shop_id == @coffee_shop.id
      @set_best_shop_id = ""
    else
      @set_best_shop_id = @coffee_shop.id
    end
  end
end
