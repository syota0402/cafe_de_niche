class CreateCoffeeShopSearchConditionsService
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
  end
  
  def create
    @coffee_shop_search_conditions= []
    
    create_name if @name.present?
    create_shop_tell if @shop_tell.present?
    create_search_category if @search_category_ids.present?
    create_review_score if @review_score.present?
    create_review_count if @review_count.present?
    create_favorite_count if @favorite_count.present?
    create_municipality if @municipality_id.present?
    create_business_hour if @business_hour.present?
    create_slack_time if @slack_time.present?
    create_age_group if @age_group.present?
    create_shop_atmosphere if @shop_atmosphere_ids.present?
    create_shop_seats if @shop_seats.present?
    create_volume_in_shop if @volume_in_shop_ids.present?
    create_food_menu if @food_menu_ids.present?
    
    
    @coffee_shop_search_conditions
  end
  
  def create_name
    @coffee_shop_search_conditions << "店舗名：#{@name}"
  end
  
  def create_shop_tell
    @coffee_shop_search_conditions << "電話番号：#{@shop_tell}"
  end
  
  def create_search_category
    search_categorys = SearchCategory.where(id: @search_category_ids)
    return_message = "こだわり：#{search_categorys.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
  def create_review_score
    @coffee_shop_search_conditions << "レビュー点数：#{@review_score}点以上" if @review_score_search_type.eql?("more_than")
    @coffee_shop_search_conditions << "レビュー点数：#{@review_score}点以下" if @review_score_search_type.eql?("less_than")
  end
  
  def create_review_count
    @coffee_shop_search_conditions << "レビュー数：#{@review_count}件以上" if @review_count_search_type.eql?("more_than")
    @coffee_shop_search_conditions << "レビュー数：#{@review_count}件以下" if @review_count_search_type.eql?("less_than")
  end
  
  def create_favorite_count
    @coffee_shop_search_conditions << "お気に入り数：#{@favorite_count}件以上" if @favorite_count_search_type.eql?("more_than")
    @coffee_shop_search_conditions << "お気に入り数：#{@favorite_count}件以下" if @favorite_count_search_type.eql?("less_than")
  end
  
  def create_municipality
    @coffee_shop_search_conditions << "エリア：#{Municipality.find(@municipality_id).name}" 
  end
    
  def create_business_hour
    @coffee_shop_search_conditions << "営業時間：#{@business_hour}"
  end
  
  def create_slack_time
    @coffee_shop_search_conditions << "すいている時間：#{@slack_time}"
  end
  
  def create_age_group
    @coffee_shop_search_conditions << "年齢層：#{@age_group}"
  end
  
  def create_shop_atmosphere
    shop_atmospheres = ShopAtmosphere.where(id: @shop_atmosphere_ids)
    return_message = "お店の雰囲気：#{shop_atmospheres.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
  def create_coffee_bean
    coffee_beans = CoffeeBean.where(id: params[:coffee_bean_ids])
    return_message = "コーヒー豆：#{coffee_beans.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
  def create_shop_seats
    @coffee_shop_search_conditions << "席数：#{@shop_seats}席以上" if @shop_seats_search_type.eql?("more_than") 
    @coffee_shop_search_conditions << "席数：#{@shop_seats}席以下" if @shop_seats_search_type.eql?("less_than")
  end
  
  def create_volume_in_shop
    volume_in_shops = VolumeInShop.where(id: @volume_in_shop_ids)
    return_message = "静かさ：#{volume_in_shops.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
  def create_food_menu
    food_menus = FoodMenu.where(id: @food_menu_ids)
    return_message = "食べ物：#{food_menus.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
end