class CoffeeShopSearchService
  def initialize(hash)
    @name = hash[:name]
    @shop_tell = hash[:shop_tell]
    @search_category_ids = hash[:search_category_ids]
    @review_score = hash[:review_score]
    @review_score_search_type = hash[:review_score_search_type]
    @review_count = hash[:review_count]
    @review_count_search_type = hash[:review_count_search_type]
    @favorite_count = hash[:favorite_count]
    @favorite_count_search_type = hash[:favorite_count_search_type]
    @municipality_id = hash[:municipality_id]
    @business_hour = hash[:business_hour]
    @slack_time = hash[:slack_time]
    @age_group = hash[:age_group]
    @shop_atmosphere_ids = hash[:shop_atmosphere_ids]
    @shop_seats = hash[:shop_seats]
    @shop_seats_search_type = hash[:shop_seats_search_type]
    @volume_in_shop_ids = hash[:volume_in_shop_ids]
    @food_menu_ids = hash[:food_menu_ids]
    @shop_bgm_ids = hash[:shop_bgm_ids]
    @pc_work = hash[:pc_work]
    @time_limit = hash[:time_limit]
    @shop_scenery_ids = hash[:shop_scenery_ids]
    @terrace_seat = hash[:terrace_seat]
    @can_reserved = hash[:can_reserved]
    @comic = hash[:comic]
    @magazine = hash[:magazine]
    @latte_art = hash[:latte_art]
    @newspaper = hash[:newspaper]
    @morning_menu = hash[:morning_menu]
    @free_water = hash[:free_water]
    @with_pet = hash[:with_pet]
    @free_pc = hash[:free_pc]
    @parking_place = hash[:parking_place]
    @payment_method_ids = hash[:payment_method_ids]
    @shop_badget = hash[:shop_badget]
    @coffee_price = hash[:coffee_price]
    @coffee_price_search_type = hash[:coffee_price_search_type]
    @latte_price = hash[:latte_price]
    @latte_price_search_type = hash[:latte_price_search_type]
    @chair_type_ids = hash[:chair_type_ids]
    @outlet = hash[:outlet]
    @wifi = hash[:wifi]
    @smoking = hash[:smoking]
    @use_scene_ids = hash[:use_scene_ids]
  end
  
  def search
    @coffee_shops = CoffeeShop.all
    
    # 店舗名　一部一致
    search_by_name if @name.present?
    
    # 電話番号　完全一致
    search_by_tell if @shop_tell.present?
    
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
    
    # すいている時間検索
    search_by_slack_time if @slack_time.present?
    
    # 年齢層検索
    search_by_age_group if @age_group.present?
    
    # 雰囲気検索
    search_by_shop_atmosphere if @shop_atmosphere_ids.present?
    
    # コーヒー豆
    search_by_coffee_bean if @coffee_bean_ids.present?
    
    # 席数
    search_by_shop_seats if @shop_seats.present?
    
    # しずかさ
    search_by_volume_in_shop if @volume_in_shop_ids.present?
    
    # 食べ物
    search_by_food_menu if @food_menu_ids.present?
    
    # BGM
    search_by_shop_bgm if @shop_bgm_ids.present?
    
    # PC作業
    search_by_pc_work if @pc_work.present?
    
    # 時間制限
    search_by_time_limit if @time_limit.present?
    
    # 風景検索
    search_by_shop_scenery if @shop_scenery_ids.present?
    
    # テラス席
    search_by_terrace_seat if @terrace_seat.present?
    
    # 貸切
    search_by_can_reserved if @can_reserved.present?
    
    # 漫画
    search_by_comic if @comic.present?
    
    # 雑誌
    search_by_magazine if @magazine.present?
    
    # ラテアート
    search_by_latte_art if @latte_art.present?
    
    # 新聞
    search_by_newspaper if @newspaper.present?
    
    # モーニング
    search_by_morning_menu if @morning_menu.present?
    
    # 無料の水
    search_by_free_water if @free_water.present?
    
    # ペット
    search_by_with_pet if @with_pet.present?
    
    # 共有PC
    search_by_free_pc if @free_pc.present?
    
    # 駐車場
    search_by_parking_place if @parking_place.present?
    
    # 支払い方法
    search_by_payment_method if @payment_method_ids.present?
    
    # 予算
    search_by_shop_badget if @shop_badget.present?
    
    # コーヒーの値段
    search_by_coffee_price if @coffee_price.present?
    
    # カフェラテの値段
    search_by_latte_price if @latte_price.present?
    
    # 椅子の種類
    search_by_chair_type if @chair_type_ids.present?
    
    # コンセント
    srarch_by_outlet if @outlet.present?
    
    # wifi
    search_by_wifi if @wifi.present?
    
    # 喫煙
    search_by_smoking if @smoking.present?
    
    # 利用シーン
    search_by_use_scene if @use_scene_ids.present?
    
    @coffee_shops
  end
  
  private
  
  # 店舗名検索
  def search_by_name
    @coffee_shops = @coffee_shops.where('name LIKE ?', "%#{@name}%")
  end
  
  # 電話番号検索
  def search_by_tell
    @coffee_shops = @coffee_shops.where(shop_tell: @shop_tell)
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
  
  # すいている時間検索
  def search_by_slack_time
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      if coffee_shop.slack_time_start.nil? or coffee_shop.slack_time_end.nil?
        next
      end
      slack_time_start = coffee_shop.slack_time_start.strftime("%H") + ":" + coffee_shop.slack_time_start.strftime("%M")
      slack_time_end = coffee_shop.slack_time_end.strftime("%H") + ":" + coffee_shop.slack_time_end.strftime("%M")
      if @slack_time.between?(slack_time_start,slack_time_end)
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # 年齢層検索
  def search_by_age_group
    @coffee_shops = @coffee_shops.where(age_group: @age_group)
  end
  
  # 雰囲気検索
  def search_by_shop_atmosphere
    coffee_shop_ids = CoffeeShopShopAtmosphere.where(shop_atmosphere_id: @shop_atmosphere_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # コーヒー豆検索
  def search_by_coffee_bean
    coffee_shop_ids = CoffeeShopCoffeeBean.where(coffee_bean_id: @coffee_bean_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  #席数検索
  def search_by_shop_seats
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      next if coffee_shop.shop_seats.nil?
      if @shop_seats_search_type.eql?("more_than") && @shop_seats.to_i <= coffee_shop.shop_seats.to_i
        coffee_shop_ids << coffee_shop.id
      elsif @shop_seats_search_type.eql?("less_than") && @shop_seats.to_i >= coffee_shop.shop_seats.to_i
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # 静かさ検索
  def search_by_volume_in_shop
    coffee_shop_ids = CoffeeShopVolumeInShop.where(volume_in_shop_id: @volume_in_shop_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # 食べ物
  def search_by_food_menu
    coffee_shop_ids = CoffeeShopFoodMenu.where(food_menu_id: @food_menu_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # BGM
  def search_by_shop_bgm
    coffee_shop_ids = CoffeeShopShopBgm.where(shop_bgm_id: @shop_bgm_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # PC作業
  def search_by_pc_work
    @coffee_shops = @coffee_shops.where(pc_work: @pc_work)
  end
  
  # 時間制限
  def search_by_time_limit
    @coffee_shops = @coffee_shops.where(time_limit: @time_limit)
  end
  
  # 風景検索
  def search_by_shop_scenery
    coffee_shop_ids = CoffeeShopShopScenery.where(shop_scenery_id: @shop_scenery_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # テラス席
  def search_by_terrace_seat
    @coffee_shops = @coffee_shops.where(terrace_seat: @terrace_seat)
  end
  
  # 貸切
  def search_by_can_reserved
    @coffee_shops = @coffee_shops.where(can_reserved: @can_reserved)
  end
  
  # 漫画
  def search_by_comic
    @coffee_shops = @coffee_shops.where(comic: @comic)
  end
  
  # 雑誌
  def search_by_magazine
    @coffee_shops = @coffee_shops.where(magazine: @magazine)
  end
  
  # ラテアート
  def search_by_latte_art
    @coffee_shops = @coffee_shops.where(latte_art: @latte_art)
  end
  
  # 新聞
  def search_by_newspaper
    @coffee_shops = @coffee_shops.where(newspaper: @newspaper)
  end
  
  # モーニング
  def search_by_morning_menu
    @coffee_shops = @coffee_shops.where(morning_menu: @morning_menu)
  end
  
  # 無料の水
  def search_by_free_water
    @coffee_shops = @coffee_shops.where(free_water: @free_water)
  end
  
  # ペット
  def search_by_with_pet
    @coffee_shops = @coffee_shops.where(with_pet: @with_pet)
  end
  
  # 共有PC
  def search_by_free_pc
    @coffee_shops = @coffee_shops.where(free_pc: @free_pc)
  end
  
  # 駐車場
  def search_by_parking_place
    @coffee_shops = @coffee_shops.where(parking_place: @parking_place)
  end
  
  # 支払い方法
  def search_by_payment_method
    coffee_shop_ids = CoffeeShopPaymentMethod.where(payment_method_id: @payment_method_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # 予算
  def search_by_shop_badget
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      if @shop_badget.to_i <= coffee_shop.shop_badget_upper.to_i && @shop_badget.to_i >= coffee_shop.shop_badget_lower.to_i
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # コーヒー1杯
  def search_by_coffee_price
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      next if coffee_shop.coffee_price.nil?
      if @coffee_price_search_type.eql?("more_than") && @coffee_price.to_i <= coffee_shop.coffee_price.to_i
        coffee_shop_ids << coffee_shop.id
      elsif @coffee_price_search_type.eql?("less_than") && @coffee_price.to_i >= coffee_shop.coffee_price.to_i
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # カフェラテ1杯
  def search_by_latte_price
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      next if coffee_shop.latte_price.nil?
      if @latte_price_search_type.eql?("more_than") && @latte_price.to_i <= coffee_shop.latte_price.to_i
        coffee_shop_ids << coffee_shop.id
      elsif @latte_price_search_type.eql?("less_than") && @latte_price.to_i >= coffee_shop.latte_price.to_i
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # 椅子の種類
  def search_by_chair_type
    coffee_shop_ids = CoffeeShopChairType.where(chair_type_id: @chair_type_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # コンセント
  def srarch_by_outlet
    @coffee_shops = @coffee_shops.where(outlet: @outlet)
  end
  
  # wifi
  def search_by_wifi
    @coffee_shops = @coffee_shops.where(wifi: @wifi)
  end
  
  # 喫煙
  def search_by_smoking
    @coffee_shops = @coffee_shops.where(smoking: @smoking)
  end
  
  # 利用シーン
  def search_by_use_scene
    coffee_shop_ids = CoffeeShopUseScene.where(use_scene_id: @use_scene_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
end