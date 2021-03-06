class CoffeeShopSearchService
  def initialize(hash,current_user)
    @current_user = current_user
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
    @coffee_bean_ids = hash[:coffee_bean_ids]
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
    @atmosphere_of_clerk_ids = hash[:atmosphere_of_clerk_ids]
    @size_of_desk_ids = hash[:size_of_desk_ids]
    @point_card_ids = hash[:point_card_ids]
    @reservation = hash[:reservation]
    @take_out = hash[:take_out]
    @with_children = hash[:with_children]
    @have_insta_account = hash[:have_insta_account]
    @amusement = hash[:amusement]
    @look_by_instagram = hash[:look_by_instagram]
    @bookmark = hash[:bookmark]
    @bookmark_by_follower = hash[:bookmark_by_follower]
    @best_shop_by_follower = hash[:best_shop_by_follower]
    @drink_menu_ids = hash[:drink_menu_ids]
  end
  
  def search
    @coffee_shops = CoffeeShop.all
    
    # ????????????????????????
    search_by_name if @name.present?
    
    # ???????????????????????????
    search_by_tell if @shop_tell.present?
    
    # ????????????????????????????????????
    search_by_search_category_ids if @search_category_ids.present?
    
    # ???????????????????????????
    search_by_review_score if @review_score.present?
    
    # ?????????????????????
    search_by_review_count if @review_count.present?
    
    # ????????????????????????
    search_by_favorite_count if @favorite_count.present?
    
    # ???????????????
    search_by_municipality_id if @municipality_id.present?
    
    # ??????????????????
    search_by_bussines_hour if @business_hour.present?
    
    # ???????????????????????????
    search_by_slack_time if @slack_time.present?
    
    # ???????????????
    search_by_age_group if @age_group.present?
    
    # ???????????????
    search_by_shop_atmosphere if @shop_atmosphere_ids.present?
    
    # ???????????????
    search_by_coffee_bean if @coffee_bean_ids.present?
    
    # ??????
    search_by_shop_seats if @shop_seats.present?
    
    # ????????????
    search_by_volume_in_shop if @volume_in_shop_ids.present?
    
    # ?????????
    search_by_food_menu if @food_menu_ids.present?
    
    # ?????????
    search_by_drink_menu if @drink_menu_ids.present?
    
    # BGM
    search_by_shop_bgm if @shop_bgm_ids.present?
    
    # PC??????
    search_by_pc_work if @pc_work.present?
    
    # ????????????
    search_by_time_limit if @time_limit.present?
    
    # ????????????
    search_by_shop_scenery if @shop_scenery_ids.present?
    
    # ????????????
    search_by_terrace_seat if @terrace_seat.present?
    
    # ??????
    search_by_can_reserved if @can_reserved.present?
    
    # ??????
    search_by_comic if @comic.present?
    
    # ??????
    search_by_magazine if @magazine.present?
    
    # ???????????????
    search_by_latte_art if @latte_art.present?
    
    # ??????
    search_by_newspaper if @newspaper.present?
    
    # ???????????????
    search_by_morning_menu if @morning_menu.present?
    
    # ????????????
    search_by_free_water if @free_water.present?
    
    # ?????????
    search_by_with_pet if @with_pet.present?
    
    # ??????PC
    search_by_free_pc if @free_pc.present?
    
    # ?????????
    search_by_parking_place if @parking_place.present?
    
    # ???????????????
    search_by_payment_method if @payment_method_ids.present?
    
    # ??????
    search_by_shop_badget if @shop_badget.present?
    
    # ?????????????????????
    search_by_coffee_price if @coffee_price.present?
    
    # ????????????????????????
    search_by_latte_price if @latte_price.present?
    
    # ???????????????
    search_by_chair_type if @chair_type_ids.present?
    
    # ???????????????
    srarch_by_outlet if @outlet.present?
    
    # wifi
    search_by_wifi if @wifi.present?
    
    # ??????
    search_by_smoking if @smoking.present?
    
    # ???????????????
    search_by_use_scene if @use_scene_ids.present?
    
    # ????????????????????????
    search_by_atmosphere_of_clerk if @atmosphere_of_clerk_ids.present?
    
    # ????????????
    search_by_size_of_desk if @size_of_desk_ids.present?
    search_by_point_card if @point_card_ids.present?
    search_by_reservation if @reservation.present?
    search_by_take_out if @take_out.present?
    search_by_with_children if @with_children.present?
    search_by_have_insta_account if @have_insta_account.present?
    search_by_amusement if @amusement.present?
    search_by_look_by_instagram if @look_by_instagram.present?
    search_by_bookmark if @bookmark.present?
    search_by_bookmark_by_follower if @bookmark_by_follower.present?
    search_by_best_shop_by_follower if @best_shop_by_follower.present?
    
    @coffee_shops
  end
  
  private
  
  # ???????????????
  def search_by_name
    @coffee_shops = @coffee_shops.where('name LIKE ?', "%#{@name}%")
  end
  
  # ??????????????????
  def search_by_tell
    @coffee_shops = @coffee_shops.where(shop_tell: @shop_tell)
  end
  
  # ??????????????????
  def search_by_search_category_ids
    coffee_shop_ids = CoffeeShopSearchCategory.where(search_category_id: @search_category_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ???????????????????????????
  def search_by_review_score
    coffee_shop_ids = []
    # ?????????????????????????????????
    @coffee_shops.each do |coffee_shop|
      next if coffee_shop.reviews.count.zero? 
      # ?????????
      review_average_score = ReviewAverageScoreService.new(coffee_shop.reviews).calculation
      # ??????
      if @review_score_search_type.eql?("more_than") && @review_score <= review_average_score
        coffee_shop_ids << coffee_shop.id
      # ??????
      elsif @review_score_search_type.eql?("less_than") && @review_score >= review_average_score
        coffee_shop_ids << coffee_shop.id
      end
    end
    # ??????????????????????????????
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ????????????????????????
  def search_by_review_count
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      # 0???????????????????????????0????????????????????????
      if @review_count.eql?("0")
        coffee_shop_ids << coffee_shop.id if coffee_shop.reviews.count.zero?
        next
      end
      
      next if coffee_shop.reviews.count.zero?
      # ??????
      if @review_count_search_type.eql?("more_than") && @review_count.to_i <= coffee_shop.reviews.count
        coffee_shop_ids << coffee_shop.id
      # ??????
      elsif @review_count_search_type.eql?("less_than") && @review_count.to_i >= coffee_shop.reviews.count
        coffee_shop_ids << coffee_shop.id
      end
    end
    # ??????????????????????????????
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ????????????????????????
  def search_by_favorite_count
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      # 0???????????????????????????0????????????????????????
      if @favorite_count.eql?("0")
        coffee_shop_ids << coffee_shop.id if coffee_shop.likers(User).count.zero?
        next
      end
      
      next if coffee_shop.likers(User).count.zero?
      # ??????
      if @favorite_count_search_type.eql?("more_than") && @favorite_count.to_i <= coffee_shop.likers(User).count
        coffee_shop_ids << coffee_shop.id
      # ??????
      elsif @favorite_count_search_type.eql?("less_than") && @favorite_count.to_i >= coffee_shop.likers(User).count
        coffee_shop_ids << coffee_shop.id
      end
    end
    # ??????????????????????????????
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ???????????????
  def search_by_municipality_id
    @coffee_shops = @coffee_shops.where(municipalitie_id: @municipality_id)
  end
  
  #?????????????????????
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
  
  # ???????????????????????????
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
  
  # ???????????????
  def search_by_age_group
    @coffee_shops = @coffee_shops.where(age_group: @age_group)
  end
  
  # ???????????????
  def search_by_shop_atmosphere
    coffee_shop_ids = CoffeeShopShopAtmosphere.where(shop_atmosphere_id: @shop_atmosphere_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ?????????????????????
  def search_by_coffee_bean
    coffee_shop_ids = CoffeeShopCoffeeBean.where(coffee_bean_id: @coffee_bean_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  #????????????
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
  
  # ???????????????
  def search_by_volume_in_shop
    coffee_shop_ids = CoffeeShopVolumeInShop.where(volume_in_shop_id: @volume_in_shop_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ?????????
  def search_by_food_menu
    coffee_shop_ids = CoffeeShopFoodMenu.where(food_menu_id: @food_menu_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ?????????
  def search_by_drink_menu
    coffee_shop_ids = CoffeeShopDrinkMenu.where(drink_menu_id: @drink_menu_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # BGM
  def search_by_shop_bgm
    coffee_shop_ids = CoffeeShopShopBgm.where(shop_bgm_id: @shop_bgm_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # PC??????
  def search_by_pc_work
    @coffee_shops = @coffee_shops.where(pc_work: @pc_work)
  end
  
  # ????????????
  def search_by_time_limit
    @coffee_shops = @coffee_shops.where(time_limit: @time_limit)
  end
  
  # ????????????
  def search_by_shop_scenery
    coffee_shop_ids = CoffeeShopShopScenery.where(shop_scenery_id: @shop_scenery_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ????????????
  def search_by_terrace_seat
    @coffee_shops = @coffee_shops.where(terrace_seat: @terrace_seat)
  end
  
  # ??????
  def search_by_can_reserved
    @coffee_shops = @coffee_shops.where(can_reserved: @can_reserved)
  end
  
  # ??????
  def search_by_comic
    @coffee_shops = @coffee_shops.where(comic: @comic)
  end
  
  # ??????
  def search_by_magazine
    @coffee_shops = @coffee_shops.where(magazine: @magazine)
  end
  
  # ???????????????
  def search_by_latte_art
    @coffee_shops = @coffee_shops.where(latte_art: @latte_art)
  end
  
  # ??????
  def search_by_newspaper
    @coffee_shops = @coffee_shops.where(newspaper: @newspaper)
  end
  
  # ???????????????
  def search_by_morning_menu
    @coffee_shops = @coffee_shops.where(morning_menu: @morning_menu)
  end
  
  # ????????????
  def search_by_free_water
    @coffee_shops = @coffee_shops.where(free_water: @free_water)
  end
  
  # ?????????
  def search_by_with_pet
    @coffee_shops = @coffee_shops.where(with_pet: @with_pet)
  end
  
  # ??????PC
  def search_by_free_pc
    @coffee_shops = @coffee_shops.where(free_pc: @free_pc)
  end
  
  # ?????????
  def search_by_parking_place
    @coffee_shops = @coffee_shops.where(parking_place: @parking_place)
  end
  
  # ???????????????
  def search_by_payment_method
    coffee_shop_ids = CoffeeShopPaymentMethod.where(payment_method_id: @payment_method_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ??????
  def search_by_shop_badget
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      if @shop_badget.to_i <= coffee_shop.shop_badget_upper.to_i && @shop_badget.to_i >= coffee_shop.shop_badget_lower.to_i
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ????????????1???
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
  
  # ???????????????1???
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
  
  # ???????????????
  def search_by_chair_type
    coffee_shop_ids = CoffeeShopChairType.where(chair_type_id: @chair_type_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ???????????????
  def srarch_by_outlet
    @coffee_shops = @coffee_shops.where(outlet: @outlet)
  end
  
  # wifi
  def search_by_wifi
    @coffee_shops = @coffee_shops.where(wifi: @wifi)
  end
  
  # ??????
  def search_by_smoking
    @coffee_shops = @coffee_shops.where(smoking: @smoking)
  end
  
  # ???????????????
  def search_by_use_scene
    coffee_shop_ids = CoffeeShopUseScene.where(use_scene_id: @use_scene_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ????????????????????????
  def search_by_atmosphere_of_clerk
    coffee_shop_ids = CoffeeShopAtmosphereOfClerk.where(atmosphere_of_clerk_id: @atmosphere_of_clerk_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ????????????
  def search_by_size_of_desk
    coffee_shop_ids = CoffeeShopSizeOfDesk.where(size_of_desk_id: @size_of_desk_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ?????????????????????
  def search_by_point_card
    coffee_shop_ids = CoffeeShopPointCard.where(point_card_id: @point_card_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ??????
  def search_by_reservation
    @coffee_shops = @coffee_shops.where(reservation: @reservation)
  end
  
  # ??????????????????
  def search_by_take_out
    @coffee_shops = @coffee_shops.where(take_out: @take_out)
  end
  
  # ???????????????
  def search_by_with_children
    @coffee_shops = @coffee_shops.where(with_children: @with_children)
  end
  
  # ??????????????????????????????
  def search_by_have_insta_account
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      next if coffee_shop.instagram_url.nil?
      if @have_insta_account.eql?("have_account") && coffee_shop.instagram_url.present?
        coffee_shop_ids << coffee_shop.id
      elsif @have_insta_account.eql?("not_have_account") && coffee_shop.instagram_url.empty?
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ????????????????????????
  def search_by_amusement
    @coffee_shops = @coffee_shops.where(amusement: @amusement)
  end
  
  # ??????????????????
  def search_by_look_by_instagram
    @coffee_shops = @coffee_shops.where(look_by_instagram: @look_by_instagram)  
  end
  
  # ????????????????????????
  def search_by_bookmark
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      if @bookmark.eql?("register") && @current_user.likes?(coffee_shop) == true
        coffee_shop_ids << coffee_shop.id
      elsif @bookmark.eql?("unregistered") && @current_user.likes?(coffee_shop) == false
        coffee_shop_ids << coffee_shop.id
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ?????????????????????????????????????????????
  def search_by_bookmark_by_follower
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      @current_user.followees(User).each do |follower|
      if @bookmark_by_follower.eql?("register") && follower.likes?(coffee_shop) == true
        coffee_shop_ids << coffee_shop.id
      elsif @bookmark_by_follower.eql?("unregistered") && follower.likes?(coffee_shop) == false
        coffee_shop_ids << coffee_shop.id
      end
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
  
  # ???????????????????????????best shop???
  def search_by_best_shop_by_follower
    coffee_shop_ids = []
    @coffee_shops.each do |coffee_shop|
      @current_user.followees(User).each do |follower|
      if @best_shop_by_follower.eql?("register") && follower.best_shop_id == coffee_shop.id
        coffee_shop_ids << coffee_shop.id
      elsif @best_shop_by_follower.eql?("unregistered") && follower.best_shop_id != coffee_shop.id
        coffee_shop_ids << coffee_shop.id
      end
      end
    end
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
end