class ReviewsController < ApplicationController
  def create
    coffee_shop = CoffeeShop.find(params[:coffee_shop_id])
    review = coffee_shop.review_new
    review.save_review(review,review_params)
    redirect_to coffee_shop_url(coffee_shop)
  end
  
  private
  def review_params
    params.require(:review).permit(:review_comment, :review_score).merge(user_id: current_user.id, coffee_shop_id: params[:coffee_shop_id])
  end
end
