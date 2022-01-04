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
    create_shop_bgm if @shop_bgm_ids.present?
    create_pc_work if @pc_work.present?
    create_time_limit if @time_limit.present?
    create_shop_scenery if @shop_scenery_ids.present?
    create_terrace_seat if @terrace_seat.present?
    create_can_reserved if @can_reserved.present?
    create_comic if @comic.present?
    create_magazine if @magazine.present?
    create_latte_art if @latte_art.present?
    create_newspaper if @newspaper.present?
    create_morning_menu if @morning_menu.present?
    create_free_water if @free_water.present?
    create_with_pet if @with_pet.present?
    create_free_pc if @free_pc.present?
    create_parking_place if @parking_place.present?
    create_payment_method if @payment_method_ids.present?
    create_shop_badget if @shop_badget.present?
    create_coffee_price if @coffee_price.present?
    create_latte_price if @latte_price.present?
    create_chair_type if @chair_type_ids.present?
    create_outlet if @outlet.present?
    create_wifi if @wifi.present?
    create_smoking if @smoking.present?
    create_use_scene if @use_scene_ids.present?
    
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
  
  def create_shop_bgm
    shop_bgms = ShopBgm.where(id: @shop_bgm_ids)
    return_message = "BGM：#{shop_bgms.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
  def create_pc_work
    @coffee_shop_search_conditions << "PC作業：#{@pc_work}"
  end
  
  def create_time_limit
    @coffee_shop_search_conditions << "時間制限：#{@time_limit}"
  end
  
  def create_shop_scenery
    shop_sceneries = ShopScenery.where(id: @shop_scenery_ids)
    return_message = "風景：#{shop_sceneries.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
  def create_terrace_seat
    @coffee_shop_search_conditions << "テラス席：#{@terrace_seat}"
  end
  
  def create_can_reserved
    @coffee_shop_search_conditions << "貸切：#{@can_reserved}"
  end
  
  def create_comic
    @coffee_shop_search_conditions << "漫画：#{@comic}"
  end
  
  def create_magazine
    @coffee_shop_search_conditions << "雑誌：#{@magazine}"
  end
  
  def create_latte_art
    @coffee_shop_search_conditions << "ラテアート：#{@latte_art}"
  end
  
  def create_newspaper
    @coffee_shop_search_conditions << "新聞：#{@newspaper}"
  end
  
  def create_morning_menu
    @coffee_shop_search_conditions << "モーニング：#{@morning_menu}"
  end
  
  def create_free_water
    @coffee_shop_search_conditions << "無料の水：#{@free_water}"
  end
  
  def create_with_pet
    @coffee_shop_search_conditions << "ペット：#{@with_pet}"
  end
  
  def create_free_pc
    @coffee_shop_search_conditions << "共有PC：#{@free_pc}"
  end
  
  def create_parking_place
    @coffee_shop_search_conditions << "駐車場：#{@parking_place}"
  end
  
  def create_payment_method
    payment_methods = PaymentMethod.where(id: @payment_method_ids)
    return_message = "風景：#{payment_methods.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
  def create_shop_badget
    @coffee_shop_search_conditions << "予算：#{@shop_badget}円"
  end
  
  def create_coffee_price
    @coffee_shop_search_conditions << "コーヒー1杯：#{@coffee_price}円以上" if @coffee_price_search_type.eql?("more_than") 
    @coffee_shop_search_conditions << "コーヒー1杯：#{@coffee_price}円以下" if @coffee_price_search_type.eql?("less_than")
  end
  
  def create_latte_price
    @coffee_shop_search_conditions << "カフェラテ1杯：#{@latte_price}円以上" if @latte_price_search_type.eql?("more_than") 
    @coffee_shop_search_conditions << "カフェラテ1杯：#{@latte_price}円以下" if @latte_price_search_type.eql?("less_than")
  end
  
  def create_chair_type
    chair_types = ChairType.where(id: @chair_type_ids)
    return_message = "椅子の種類：#{chair_types.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
  # コンセント
  def create_outlet
    @coffee_shop_search_conditions << "コンセント：#{CoffeeShop.outlets_i18n[@outlet]}"
  end
  
  # WI-Fi
  def create_wifi
    @coffee_shop_search_conditions << "Wi-Fi：#{CoffeeShop.wifis_i18n[@wifi]}"
  end
  
  # 喫煙・禁煙
  def create_smoking
    @coffee_shop_search_conditions << "喫煙・禁煙：#{CoffeeShop.smokings_i18n[@smoking]}"
  end
  
  # 利用シーン
  def create_use_scene
    use_scenes = UseScene.where(id: @use_scene_ids)
    return_message = "利用シーン：#{use_scenes.pluck(:name).join('or')}"
    @coffee_shop_search_conditions << return_message
  end
  
end