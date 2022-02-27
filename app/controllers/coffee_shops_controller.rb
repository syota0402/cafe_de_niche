class CoffeeShopsController < ApplicationController
  PER = 10
  
  def show
    @coffee_shop = CoffeeShop.find(params[:id])
    reviews = @coffee_shop.reviews.order("created_at DESC")
    @reviews_count = reviews.count
    @reviews = reviews.page(params[:page]).per(PER)
    @review = Review.new
    @likers = @coffee_shop.likers(User)
    # 店舗のレビューの平均点を計算
    @review_average_score = ReviewAverageScoreService.new(reviews).calculation
    # 店舗の詳細情報を取得
    @coffee_shop_show_info_service = CoffeeShopShowInfoService.new(@coffee_shop)
    @shop_info = @coffee_shop_show_info_service.create
    @shop_tell = @coffee_shop_show_info_service.create_tell_number
  end

  def search
    # 検索条件を表示する配列を作る
    @create_coffeee_shop_search_conditions_service = CreateCoffeeShopSearchConditionsService.new(set_search_hash)
    @coffee_shop_search_conditions = @create_coffeee_shop_search_conditions_service.create
    # 検索条件をもとに店舗を検索する
    @coffee_shop_search_service = CoffeeShopSearchService.new(set_search_hash,current_user)
    coffee_shops = @coffee_shop_search_service.search
    @coffee_shops = coffee_shops.page(params[:page]).per(PER)
    @coffee_shops_count = coffee_shops.count
  end
  
  def favorite
    @coffee_shop = CoffeeShop.find(params[:id])
    current_user.toggle_like!(@coffee_shop)
    if params[:target_action] == "show"
      redirect_to coffee_shop_url @coffee_shop
    elsif params[:target_action] == "favorite"
      redirect_to favorite_users_path
    end
  end
  
  private
    
    def set_search_hash
      hash = {}
      hash.class
      hash[:name] = params[:name]
      hash[:shop_tell] = params[:shop_tell]
      hash[:search_category_ids] = params[:search_category_ids]
      hash[:review_score] = params[:review_score]
      hash[:review_score_search_type] = params[:review_score_search_type]
      hash[:review_count] = params[:review_count]
      hash[:review_count_search_type] = params[:review_count_search_type]
      hash[:favorite_count] = params[:favorite_count]
      hash[:favorite_count_search_type] = params[:favorite_count_search_type]
      hash[:municipality_id] = params[:municipality_id]
      hash[:business_hour] = params[:business_hour]
      hash[:slack_time] = params[:slack_time]
      hash[:age_group] = params[:age_group]
      hash[:shop_atmosphere_ids] = params[:shop_atmosphere_ids]
      hash[:coffee_bean_ids] = params[:coffee_bean_ids]
      hash[:shop_seats] = params[:shop_seats]
      hash[:shop_seats_search_type] = params[:shop_seats_search_type]
      hash[:volume_in_shop_ids] = params[:volume_in_shop_ids]
      hash[:food_menu_ids] = params[:food_menu_ids]
      hash[:drink_menu_ids] = params[:drink_menu_ids]
      hash[:shop_bgm_ids] = params[:shop_bgm_ids]
      hash[:pc_work] = params[:pc_work]
      hash[:time_limit] = params[:time_limit]
      hash[:shop_scenery_ids] = params[:shop_scenery_ids]
      hash[:terrace_seat] = params[:terrace_seat]
      hash[:can_reserved] = params[:can_reserved]
      hash[:comic] = params[:comic]
      hash[:magazine] = params[:magazine]
      hash[:latte_art] = params[:latte_art]
      hash[:newspaper] = params[:newspaper]
      hash[:morning_menu] = params[:morning_menu]
      hash[:free_water] = params[:free_water]
      hash[:with_pet] = params[:with_pet]
      hash[:free_pc] = params[:free_pc]
      hash[:parking_place] = params[:parking_place]
      hash[:payment_method_ids] = params[:payment_method_ids]
      hash[:shop_badget] = params[:shop_badget]
      hash[:coffee_price] = params[:coffee_price]
      hash[:coffee_price_search_type] = params[:coffee_price_search_type]
      hash[:latte_price] = params[:latte_price]
      hash[:latte_price_search_type] = params[:latte_price_search_type]
      hash[:chair_type_ids] = params[:chair_type_ids]
      hash[:outlet] = params[:outlet]
      hash[:wifi] = params[:wifi]
      hash[:smoking] = params[:smoking]
      hash[:use_scene_ids] = params[:use_scene_ids]
      hash[:atmosphere_of_clerk_ids] = params[:atmosphere_of_clerk_ids]
      hash[:size_of_desk_ids] = params[:size_of_desk_ids]
      hash[:point_card_ids] = params[:point_card_ids]
      hash[:reservation] = params[:reservation]
      hash[:take_out] = params[:take_out]
      hash[:with_children] = params[:with_children]
      hash[:have_insta_account] = params[:have_insta_account]
      hash[:amusement] = params[:amusement]
      hash[:look_by_instagram] = params[:look_by_instagram]
      hash[:bookmark] = params[:bookmark]
      hash[:bookmark_by_follower] = params[:bookmark_by_follower]
      hash[:best_shop_by_follower] = params[:best_shop_by_follower]
      hash
    end
end
