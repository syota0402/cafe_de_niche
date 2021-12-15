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
  
  def create_pc_work
    hash = {}
    hash.class
    hash[:title] = 'PC作業'
    hash[:value] = @coffee_shop.pc_work
    @shop_info << hash
  end
  
  def create_time_limit
    hash = {}
    hash.class
    hash[:title] = '時間制限'
    hash[:value] = @coffee_shop.time_limit
    @shop_info << hash
  end
  
  def create_shop_scenety
    hash = {}
    hash.class
    hash[:title] = '風景'
    hash[:value] = @coffee_shop.shop_sceneries.pluck(:name).join(',')
    @shop_info << hash
  end
end