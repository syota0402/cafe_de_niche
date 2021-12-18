class CoffeeShopShowInfoService
  def initialize(coffee_shop)
    @coffee_shop = coffee_shop
  end
  
  def create
    @shop_info = []
    
    create_required_item
    create_access if @coffee_shop.access.present?
    create_business_hour if @coffee_shop.business_start_hour.present?
    create_search_category if @coffee_shop.search_categories.present?
    create_slack_time if @coffee_shop.slack_time_start.present?
    create_age_group if @coffee_shop.age_group.present?
    create_shop_atomosphere if @coffee_shop.shop_atmospheres.present? 
    create_coffee_bean if @coffee_shop.coffee_beans.present?
    create_shop_seat if @coffee_shop.shop_seats.present?
    create_volume_in_shop if @coffee_shop.volume_in_shops.present?
    create_food_menu if @coffee_shop.food_menus.present?
    create_shop_bgm if @coffee_shop.shop_bgms.present?
    create_pc_work if @coffee_shop.pc_work.present?
    create_time_limit if @coffee_shop.time_limit.present?
    create_shop_scenety if @coffee_shop.shop_sceneries.present?
    create_terrace_seat if @coffee_shop.terrace_seat.present?
    create_can_reserved if @coffee_shop.can_reserved.present?
    create_comic if @coffee_shop.comic.present?
    create_magazine if @coffee_shop.magazine.present?
    create_latte_art if @coffee_shop.latte_art.present?
    create_newspaper if @coffee_shop.newspaper.present?
    create_morning_menu if @coffee_shop.morning_menu.present?
    create_free_water if @coffee_shop.free_water.present?
    create_with_pet if @coffee_shop.with_pet.present?
    create_free_pc if @coffee_shop.free_pc.present?
    create_parking_place if @coffee_shop.parking_place.present?
    
    @shop_info
  end
  
  private
  # 必須項目
  def create_required_item
    
    # 住所
    hash = {}
    hash.class
    hash[:title] = '住所'
    hash[:value] = @coffee_shop.address
    @shop_info << hash
    
    # 定休日
    hash = {}
    hash.class
    hash[:title] = '定休日'
    hash[:value] = @coffee_shop.regular_holiday
    @shop_info << hash
    
    # エリア
    hash = {}
    hash.class
    hash[:title] = 'エリア'
    hash[:value] = Municipality.find(@coffee_shop.municipalitie_id).name
    @shop_info << hash
    
  end
  
  # アクセス
  def create_access
    hash = {}
    hash.class
    hash[:title] = 'アクセス'
    hash[:value] = @coffee_shop.access
    @shop_info << hash
  end
  
  # 営業時間
  def create_business_hour
    hash = {}
    hash.class
    hash[:title] = '営業時間'
    hash[:value] = "#{@coffee_shop.business_start_hour.strftime("%H:%M")}から#{@coffee_shop.business_end_hour.strftime("%H:%M")}まで"
    @shop_info << hash
  end
  
  # カテゴリ
  def create_search_category
    hash = {}
    hash.class
    hash[:title] = 'こだわり'
    hash[:value] = @coffee_shop.search_categories.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # 空いている時間
  def create_slack_time
    hash = {}
    hash.class
    hash[:title] = 'すいている時間'
    hash[:value] = "#{@coffee_shop.slack_time_start.strftime("%H:%M")}から#{@coffee_shop.slack_time_end.strftime("%H:%M")}まで"
    @shop_info << hash
  end
  
  # 年齢層
  def create_age_group
    hash = {}
    hash.class
    hash[:title] = '年齢層'
    hash[:value] = @coffee_shop.age_group
    @shop_info << hash
  end
  
  # お店の雰囲気
  def create_shop_atomosphere
    hash = {}
    hash.class
    hash[:title] = 'お店の雰囲気'
    hash[:value] = @coffee_shop.shop_atmospheres.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # コーヒー豆
  def create_coffee_bean
    hash = {}
    hash.class
    hash[:title] = 'コーヒー豆'
    hash[:value] = @coffee_shop.coffee_beans.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # 席数
  def create_shop_seat
    hash = {}
    hash.class
    hash[:title] = '席数'
    hash[:value] = "#{@coffee_shop.shop_seats}席"
    @shop_info << hash
  end
  
  # 静かさ
  def create_volume_in_shop
    hash = {}
    hash.class
    hash[:title] = '静かさ'
    hash[:value] = @coffee_shop.volume_in_shops.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # 食べ物
  def create_food_menu
    hash = {}
    hash.class
    hash[:title] = '食べ物'
    hash[:value] = @coffee_shop.food_menus.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # BGM
  def create_shop_bgm
    hash = {}
    hash.class
    hash[:title] = 'BGM'
    hash[:value] = @coffee_shop.shop_bgms.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # PC作業
  def create_pc_work
    hash = {}
    hash.class
    hash[:title] = 'PC作業'
    hash[:value] = @coffee_shop.pc_work
    @shop_info << hash
  end
  
  # 時間制限
  def create_time_limit
    hash = {}
    hash.class
    hash[:title] = '時間制限'
    hash[:value] = @coffee_shop.time_limit
    @shop_info << hash
  end
  
  # 風景
  def create_shop_scenety
    hash = {}
    hash.class
    hash[:title] = '風景'
    hash[:value] = @coffee_shop.shop_sceneries.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # テラス席
  def create_terrace_seat
    hash = {}
    hash.class
    hash[:title] = 'テラス席'
    hash[:value] = @coffee_shop.terrace_seat
    @shop_info << hash
  end
  
  # 貸切
  def create_can_reserved
    hash = {}
    hash.class
    hash[:title] = '貸切'
    hash[:value] = @coffee_shop.can_reserved
    @shop_info << hash
  end
  
  # 漫画
  def create_comic
    hash = {}
    hash.class
    hash[:title] = '漫画'
    hash[:value] = @coffee_shop.comic
    @shop_info << hash
  end
  
  # 雑誌
  def create_magazine
    hash = {}
    hash.class
    hash[:title] = '雑誌'
    hash[:value] = @coffee_shop.magazine
    @shop_info << hash
  end
  
  # ラテアート
  def create_latte_art
    hash = {}
    hash.class
    hash[:title] = 'ラテアート'
    hash[:value] = @coffee_shop.latte_art
    @shop_info << hash
  end
  
  # 新聞
  def create_newspaper
    hash = {}
    hash.class
    hash[:title] = '新聞'
    hash[:value] = @coffee_shop.newspaper
    @shop_info << hash
  end
  
  # モーニング
  def create_morning_menu
    hash = {}
    hash.class
    hash[:title] = 'モーニング'
    hash[:value] = @coffee_shop.morning_menu
    @shop_info << hash
  end
  
  # 無料の水
  def create_free_water
    hash = {}
    hash.class
    hash[:title] = '無料の水'
    hash[:value] = @coffee_shop.free_water
    @shop_info << hash
  end
  
  # ペット
  def create_with_pet
    hash = {}
    hash.class
    hash[:title] = 'ペット'
    hash[:value] = @coffee_shop.with_pet
    @shop_info << hash
  end
  
  # 共有PC
  def create_free_pc
    hash = {}
    hash.class
    hash[:title] = '共有PC'
    hash[:value] = @coffee_shop.free_pc
    @shop_info << hash
  end
  
  # 駐車場
  def create_parking_place
    hash = {}
    hash.class
    hash[:title] = '駐車場'
    hash[:value] = @coffee_shop.parking_place
    @shop_info << hash
  end
  
end