class CoffeeShopSearchService
  def initialize(name,tell,search_category_ids,review_score,review_score_search_type)
    @name = name
    @tell = tell
    @search_category_ids = search_category_ids
    @review_score = review_score
    @review_score_search_type = review_score_search_type
  end
  
  def search
    @coffee_shops = CoffeeShop.all
    
    # 店舗名　一部一致
    search_by_name if @name.present?
    
    # 電話番号　完全一致
    search_by_tell if @tell.present?
    
    search_by_search_category_ids if @search_category_ids.present?
    
    search_by_review_score if @review_score.present?
    
    @coffee_shops
  end
  
  private
  
  def search_by_name
    @coffee_shops = @coffee_shops.where('name LIKE ?', "%#{@name}%")
  end
  
  def search_by_tell
    @coffee_shops = @coffee_shops.where(tell: @tell)
  end
  
  def search_by_search_category_ids
    coffee_shop_ids = CoffeeShopSearchCategory.where(search_category_id: @search_category_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  def search_by_review_score
    coffee_shop_ids = []
    # 店舗の平均スコアを取得
    @coffee_shops.each do |coffee_shop|
      next if coffee_shop.reviews.count.zero? 
      # 平均点
      review_average_score = ReviewAverageScoreService.new(coffee_shop.reviews).calculation
      # 以上
      if @review_score_search_type.eql?("more_than") && @review_score <= review_average_score
        coffee_shop_ids << coffee_shop.id
      # 以下
      elsif @review_score_search_type.eql?("less_than") && @review_score >= review_average_score
        coffee_shop_ids << coffee_shop.id
      end
    end
    
    # 条件にあう店舗を取得
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
end