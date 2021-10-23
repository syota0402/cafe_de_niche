class Review < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :user
  
  # バリデーション
  # 必須項目
  validates :review_comment, :review_score, presence: true
  
  # 文字数
  validates :review_comment, length: { maximum: 150}
  
  # 点数の範囲　0~100
  validates :review_score, numericality: { in: 0..100 }
  
  def save_review(review, review_params)
    review.review_comment = review_params[:review_comment]
    review.user_id = review_params[:user_id]
    review.coffee_shop_id = review_params[:coffee_shop_id]
    review.review_score = review_params[:review_score]
    save
  end
  
end
