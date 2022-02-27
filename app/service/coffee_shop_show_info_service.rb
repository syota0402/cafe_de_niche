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
    create_drink_menu if @coffee_shop.drink_menus.present?
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
    create_payment_method if @coffee_shop.payment_methods.present?
    create_shop_badget if @coffee_shop.shop_badget_lower.present?
    create_coffee_price if @coffee_shop.coffee_price.present?
    create_latte_price if @coffee_shop.latte_price.present?
    create_chair_type if @coffee_shop.chair_types.present?
    create_outlet if @coffee_shop.outlet.present?
    create_wifi if @coffee_shop.wifi.present?
    create_smoking if @coffee_shop.smoking.present?
    create_use_scene if @coffee_shop.use_scenes.present?
    create_atmosphere_of_clerk if @coffee_shop.atmosphere_of_clerks.present?
    create_size_of_desk if @coffee_shop.size_of_desks.present?
    create_point_card if @coffee_shop.point_cards.present?
    create_reservation if @coffee_shop.reservation.present?
    create_take_out if @coffee_shop.take_out.present?
    create_with_children if @coffee_shop.with_children.present?
    create_amusement if @coffee_shop.amusement.present?
    create_look_by_instagram if @coffee_shop.look_by_instagram.present?
    
    @shop_info
  end
  
  # 電話番号に「-」をつける
  def create_tell_number
    tell =  @coffee_shop.shop_tell
    
    @shop_tell = ""
    if @coffee_shop.tell_secret
      @shop_tell = "非公開"
    elsif tell.length == 10
      @shop_tell = "#{tell[0,2]}-#{tell[2,4]}-#{tell[6,4]}"
    elsif tell.length == 11
      @shop_tell = "#{tell[0,3]}-#{tell[3,4]}-#{tell[7,4]}"
    end
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
  
  # 飲み物
  def create_drink_menu
    hash = {}
    hash.class
    hash[:title] = '飲み物'
    hash[:value] = @coffee_shop.drink_menus.pluck(:name).join(',')
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
  
  # 支払い方法
  def create_payment_method
    hash = {}
    hash.class
    hash[:title] = '支払い方法'
    hash[:value] = @coffee_shop.payment_methods.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # 予算
  def create_shop_badget
    hash = {}
    hash.class
    hash[:title] = '予算'
    hash[:value] = '¥' + @coffee_shop.shop_badget_lower.to_s + '〜¥' + @coffee_shop.shop_badget_upper.to_s
    @shop_info << hash
  end
  
  # コーヒーの値段
  def create_coffee_price
    hash = {}
    hash.class
    hash[:title] = 'コーヒー(1杯)の値段'
    hash[:value] = '¥' + @coffee_shop.coffee_price.to_s
    @shop_info << hash
  end
  
  # カフェラテの値段
  def create_latte_price
    hash = {}
    hash.class
    hash[:title] = 'カフェラテ(1杯)の値段'
    hash[:value] = '¥' + @coffee_shop.latte_price.to_s
    @shop_info << hash
  end
  
  # 椅子の種類
  def create_chair_type
    hash = {}
    hash.class
    hash[:title] = '椅子の種類'
    hash[:value] = @coffee_shop.chair_types.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # コンセント
  def create_outlet
    hash = {}
    hash.class
    hash[:title] = 'コンセント'
    hash[:value] = @coffee_shop.outlet_i18n
    @shop_info << hash
  end
  
  # Wi-Fi
  def create_wifi
    hash = {}
    hash.class
    hash[:title] = 'Wi-Fi'
    hash[:value] = @coffee_shop.wifi_i18n
    @shop_info << hash
  end
  
  # 喫煙
  def create_smoking
    hash = {}
    hash.class
    hash[:title] = '喫煙・禁煙'
    hash[:value] = @coffee_shop.smoking_i18n
    @shop_info << hash
  end
  
  # 利用シーン
  def create_use_scene
    hash = {}
    hash.class
    hash[:title] = '利用シーン'
    hash[:value] = @coffee_shop.use_scenes.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # 店員さんの雰囲気
  def create_atmosphere_of_clerk
    hash = {}
    hash.class
    hash[:title] = '店員さんの雰囲気'
    hash[:value] = @coffee_shop.atmosphere_of_clerks.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # 机の広さ
  def create_size_of_desk
    hash = {}
    hash.class
    hash[:title] = '机の広さ'
    hash[:value] = @coffee_shop.size_of_desks.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # ポイントカード
  def create_point_card
    hash = {}
    hash.class
    hash[:title] = 'ポイントカード'
    hash[:value] = @coffee_shop.point_cards.pluck(:name).join(',')
    @shop_info << hash
  end
  
  # 予約
  def create_reservation
    hash = {}
    hash.class
    hash[:title] = '予約'
    hash[:value] = @coffee_shop.reservation_i18n
    @shop_info << hash
  end
  
  # テイクアウト
  def create_take_out
    hash = {}
    hash.class
    hash[:title] = 'テイクアウト'
    hash[:value] = @coffee_shop.take_out_i18n
    @shop_info << hash
  end
  
  # お子様連れ
  def create_with_children
    hash = {}
    hash.class
    hash[:title] = 'お子様連れ'
    hash[:value] = @coffee_shop.with_children_i18n
    @shop_info << hash
  end
  
  # アミューズメント
  def create_amusement
    hash = {}
    hash.class
    hash[:title] = 'アミューズメント'
    hash[:value] = @coffee_shop.amusement_i18n
    @shop_info << hash
  end
  
  # インスタ映え
  def create_look_by_instagram
    hash = {}
    hash.class
    hash[:title] = 'インスタ映え'
    hash[:value] = @coffee_shop.look_by_instagram_i18n
    @shop_info << hash
  end
  
end