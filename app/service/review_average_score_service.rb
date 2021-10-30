class ReviewAverageScoreService
  def initialize(reviews)
    @reviews = reviews
  end
  
  def calculation
    all_score = 0
    @reviews.each do |review|
      all_score = all_score + review.review_score
    end
    if @reviews.count.zero?
      sprintf("%.2f",0)
    else
      sprintf("%.2f",all_score/@reviews.count.to_f)
    end
  end
end