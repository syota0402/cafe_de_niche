class ReviewsController < ApplicationController
  def create
    coffee_shop = CoffeeShop.find(params[:coffee_shop_id])
    review = coffee_shop.review_new
    # if review_params[:review_score].to_i <= 100 && review_params[:review_score].to_i >= 0
    if review.save_review(review,review_params)
      redirect_to coffee_shop_url(coffee_shop)
    else
      flash[:alert] = review.errors.full_messages
      redirect_back(fallback_location: coffee_shop_url(coffee_shop))
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    coffee_shop = CoffeeShop.find(@review.coffee_shop_id)
    @review.destroy
    redirect_to coffee_shop_url(coffee_shop)
  end
  
  private
  def review_params
    params.require(:review).permit(:review_comment, :review_score, :image).merge(user_id: current_user.id, coffee_shop_id: params[:coffee_shop_id])
  end
end