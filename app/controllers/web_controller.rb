class WebController < ApplicationController
  def index
    @rank_favorite_coffee_shops = CoffeeShop.find(CoffeeShop.all.order('likers_count desc').limit(5).pluck(:id))
    @rank_follow_users = User.find(User.all.order('followers_count desc').limit(5).pluck(:id))
    @rank_review_users = User.find(Review.group(:user_id).order('count(user_id)desc').limit(5).pluck(:user_id))
    if user_signed_in?
      @my_best_shop = CoffeeShop.find(current_user.best_shop_id) if current_user.best_shop_id.present?
    end
  end
  
  def search
    @municipalities = Municipality.where(prefecture_id: params[:prefecture_id])
  end
end
