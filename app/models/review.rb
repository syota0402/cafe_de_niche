class Review < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :user
  
  def save_review(review, review_params)
    review.review_comment = review_params[:review_comment]
    review.user_id = review_params[:user_id]
    review.coffee_shop_id = review_params[:coffee_shop_id]
    review.review_score = review_params[:review_score]
    save
  end
  
end
