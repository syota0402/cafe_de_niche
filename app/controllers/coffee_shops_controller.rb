class CoffeeShopsController < ApplicationController

  def show
    @coffee_shop = CoffeeShop.find(params[:id])
    @reviews = @coffee_shop.reviews
    @review = Review.new
    @likers = @coffee_shop.likers(User)
    set_shop_business_hour(@coffee_shop)
    set_slack_time(@coffee_shop)
    # 店舗のレビューの平均点を計算
    @review_average_score = ReviewAverageScoreService.new(@reviews).calculation
    @search_category = @coffee_shop.search_categories.pluck(:name).join(',')
    @shop_atmospere = @coffee_shop.shop_atmospheres.pluck(:name).join(',')
    @coffee_bean = @coffee_shop.coffee_beans.pluck(:name).join(',')
    @volume_in_shop = @coffee_shop.volume_in_shops.pluck(:name).join(',')
    @food_menu = @coffee_shop.food_menus.pluck(:name).join(',')
  end

  def search
    # 検索条件を表示する配列を作る
    @create_coffeee_shop_search_conditions_service = CreateCoffeeShopSearchConditionsService.new(set_search_hash)
    @coffee_shop_search_conditions = @create_coffeee_shop_search_conditions_service.create
    # 検索条件をもとに店舗を検索する
    @coffee_shop_search_service = CoffeeShopSearchService.new(set_search_hash)
    @coffee_shops = @coffee_shop_search_service.search
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
    
    def set_shop_business_hour(coffee_shop)
      @shop_business_hour = ""
      @shop_business_hour << "#{coffee_shop.business_start_hour.strftime("%H:%M")}から" if coffee_shop.business_start_hour.present?
      @shop_business_hour << "#{coffee_shop.business_end_hour.strftime("%H:%M")}まで" if coffee_shop.business_end_hour.present?
    end
    
    def set_slack_time(coffee_shop)
      @slack_time = ""
      @slack_time << "#{coffee_shop.slack_time_start.hour}:#{coffee_shop.slack_time_start.min}から" if coffee_shop.slack_time_start.present?
      @slack_time << "#{coffee_shop.slack_time_end.hour}:#{coffee_shop.slack_time_end.min}まで" if coffee_shop.slack_time_end.present?
    end
    
    def set_search_hash
      hash = {}
      hash.class
      hash[:name] = params[:name]
      hash[:tell] = params[:tell]
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
      hash
    end
end
