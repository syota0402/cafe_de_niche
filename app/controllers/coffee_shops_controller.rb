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
    # 表示させる配列作る
    set_coffee_shop_search_conditions(set_search_hash)
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
    # def coffee_shop_params
    #   params.require(:coffee_shop).permit(:name, :shop_url, :address, :tell, :access, :business_start_hour, :business_end_hour, :regular_holiday, :instagram_url, :instagram_spot_url, :municipalitie_id, images: [])
    # end
    
    def set_shop_business_hour(coffee_shop)
      @shop_business_hour = ""
      @shop_business_hour << "#{coffee_shop.business_start_hour.hour}:#{coffee_shop.business_start_hour.min}から" if coffee_shop.business_start_hour.present?
      @shop_business_hour << "#{coffee_shop.business_end_hour.hour}:#{coffee_shop.business_end_hour.min}まで" if coffee_shop.business_end_hour.present?
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
    
    def set_coffee_shop_search_conditions(hash)
      @coffee_shop_search_conditions = []
      @coffee_shop_search_conditions << "店舗名：#{params[:name]}" if params[:name].present?
      @coffee_shop_search_conditions << "電話番号：#{params[:tel]}" if params[:tell].present?
      if params[:search_category_ids].present?
        search_categorys = SearchCategory.where(id: params[:search_category_ids])
        return_message = "こだわり："
        search_categorys.each_with_index do |search_category, i|
          if i.eql?(0)
            return_message << "#{search_category.name}"
          else
            return_message << "or#{search_category.name}"
          end
        end
        @coffee_shop_search_conditions << return_message
      end
      if params[:review_score].present?
        @coffee_shop_search_conditions << "レビュー点数：#{params[:review_score]}点以上" if params[:review_score_search_type].eql?("more_than")
        @coffee_shop_search_conditions << "レビュー点数：#{params[:review_score]}点以下" if params[:review_score_search_type].eql?("less_than")
      end
      if params[:review_count].present?
        @coffee_shop_search_conditions << "レビュー数：#{params[:review_count]}件以上" if params[:review_count_search_type].eql?("more_than")
        @coffee_shop_search_conditions << "レビュー数：#{params[:review_count]}件以下" if params[:review_count_search_type].eql?("less_than")
      end
      if params[:favorite_count].present?
        @coffee_shop_search_conditions << "お気に入り数：#{params[:favorite_count]}件以上" if params[:favorite_count_search_type].eql?("more_than")
        @coffee_shop_search_conditions << "お気に入り数：#{params[:favorite_count]}件以下" if params[:favorite_count_search_type].eql?("less_than")
      end
      @coffee_shop_search_conditions << "エリア：#{Municipality.find(params[:municipality_id]).name}" if params[:municipality_id].present?
      @coffee_shop_search_conditions << "営業時間：#{params[:business_hour]}" if params[:business_hour].present?
      @coffee_shop_search_conditions << "すいている時間：#{params[:slack_time]}" if params[:slack_time].present?
      @coffee_shop_search_conditions << "年齢層：#{params[:age_group]}" if params[:age_group].present?
      if params[:shop_atmosphere_ids].present?
        shop_atmospheres = ShopAtmosphere.where(id: params[:shop_atmosphere_ids])
        return_message = "お店の雰囲気："
        shop_atmospheres.each_with_index do |shop_atmospere, i|
          if i.eql?(0)
            return_message << "#{shop_atmospere.name}"
          else
            return_message << "or#{shop_atmospere.name}"
          end
        end
        @coffee_shop_search_conditions << return_message
      end
      if params[:coffee_bean_ids].present?
        coffee_beans = CoffeeBean.where(id: params[:coffee_bean_ids])
        return_message = "コーヒー豆："
        coffee_beans.each_with_index do |coffee_bean, i|
          if i.eql?(0)
            return_message << "#{coffee_bean.name}"
          else
            return_message << "or#{coffee_bean.name}"
          end
        end
        @coffee_shop_search_conditions << return_message
      end
      if params[:shop_seats].present?
        @coffee_shop_search_conditions << "席数：#{params[:shop_seats]}席以上" if params[:shop_seats_search_type].eql?("more_than") 
        @coffee_shop_search_conditions << "席数：#{params[:shop_seats]}席以下" if params[:shop_seats_search_type].eql?("less_than")
      end
      if params[:volume_in_shop_ids].present?
        volume_in_shops = VolumeInShop.where(id: params[:volume_in_shop_ids])
        return_message = "静かさ："
        volume_in_shops.each_with_index do |volume_in_shop, i|
          if i.eql?(0)
            return_message << "#{volume_in_shop.name}"
          else
            return_message << "or#{volume_in_shop.name}"
          end
        end
        @coffee_shop_search_conditions << return_message
      end
      if params[:food_menu_ids].present?
        food_menus = FoodMenu.where(id: params[:food_menu_ids])
        return_message = "食べ物："
        food_menus.each_with_index do |food_menu, i|
          if i.eql?(0)
            return_message << "#{food_menu.name}"
          else
            return_message << "or#{food_menu.name}"
          end
        end
        @coffee_shop_search_conditions << return_message
      end
    end
end
