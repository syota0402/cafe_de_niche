class CoffeeShopSearchService
  def initialize(hash)
    @name = hash[:name]
    @tell = hash[:tell]
    @search_category_ids = hash[:search_category_ids]
    @review_score = hash[:review_score]
    @review_score_search_type = hash[:review_score_search_type]
    @review_count = hash[:review_count]
    @review_count_search_type = hash[:review_count_search_type]
    @favorite_count = hash[:favorite_count]
    @favorite_count_search_type = hash[:favorite_count_search_type]
    @municipality_id = hash[:municipality_id]
    @business_hour = hash[:business_hour]
  end
  
  def search
    @coffee_shops = CoffeeShop.all
    
    # 店舗名　一部一致
    search_by_name if @name.present?
    
    # 電話番号　完全一致
    search_by_tell if @tell.present?
    
    # こだわり検索　複数選択可
    search_by_search_category_ids if @search_category_ids.present?
    
    # レビュースコア検索
    search_by_review_score if @review_score.present?
    
    # レビュー数検索
    search_by_review_count if @review_count.present?
    
    # お気に入り数検索
    search_by_favorite_count if @favorite_count.present?
    
    # エリア検索
    search_by_municipality_id if @municipality_id.present?
    
    # 営業時間検索
    search_by_bussines_hour if @business_hour.present?
    
    @coffee_shops
  end
  
  private
  
  # 店舗名検索
  def search_by_name
    @coffee_shops = @coffee_shops.where('name LIKE ?', "%#{@name}%")
  end
  
  # 電話番号検索
  def search_by_tell
    @coffee_shops = @coffee_shops.where(tell: @tell)
  end
  
  # こだわり検索
  def search_by_search_category_ids
    coffee_shop_ids = CoffeeShopSearchCategory.where(search_category_id: @search_category_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # レビュースコア検索
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
  
  # レビュー件数検索
  def search_by_review_count
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      # 0が検索条件にあれば0件の店舗のみ表示
      if @review_count.eql?("0")
        coffee_shop_ids << coffee_shop.id if coffee_shop.reviews.count.zero?
        next
      end
      
      next if coffee_shop.reviews.count.zero?
      # 以上
      if @review_count_search_type.eql?("more_than") && @review_count.to_i <= coffee_shop.reviews.count
        coffee_shop_ids << coffee_shop.id
      # 以下
      elsif @review_count_search_type.eql?("less_than") && @review_count.to_i >= coffee_shop.reviews.count
        coffee_shop_ids << coffee_shop.id
      end
    end
    # 条件にあう店舗を取得
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # お気に入り数検索
  def search_by_favorite_count
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      # 0が検索条件にあれば0件の店舗のみ表示
      if @favorite_count.eql?("0")
        coffee_shop_ids << coffee_shop.id if coffee_shop.likers(User).count.zero?
        next
      end
      
      next if coffee_shop.likers(User).count.zero?
      # 以上
      if @favorite_count_search_type.eql?("more_than") && @favorite_count.to_i <= coffee_shop.likers(User).count
        coffee_shop_ids << coffee_shop.id
      # 以下
      elsif @favorite_count_search_type.eql?("less_than") && @favorite_count.to_i >= coffee_shop.likers(User).count
        coffee_shop_ids << coffee_shop.id
      end
    end
    # 条件にあう店舗を取得
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # エリア検索
  def search_by_municipality_id
    @coffee_shops = @coffee_shops.where(municipalitie_id: @municipality_id)
  end
  
  #　営業時間検索
  def search_by_bussines_hour
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      if coffee_shop.business_start_hour.nil? or coffee_shop.business_end_hour.nil?
        next
      end
      business_start_hour = coffee_shop.business_start_hour.strftime("%H") + ":" + coffee_shop.business_start_hour.strftime("%M")
      business_end_hour = coffee_shop.business_end_hour.strftime("%H") + ":" + coffee_shop.business_end_hour.strftime("%M")
      if @business_hour.between?(business_start_hour,business_end_hour)
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
end