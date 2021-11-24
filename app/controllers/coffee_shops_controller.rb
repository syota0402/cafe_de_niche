class CoffeeShopsController < ApplicationController

  def show
    @coffee_shop = CoffeeShop.find(params[:id])
    @reviews = @coffee_shop.reviews
    @review = Review.new
    @likers = @coffee_shop.likers(User)
    # 店舗のレビューの平均点を計算
    @review_average_score = ReviewAverageScoreService.new(@reviews).calculation
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
    def coffee_shop_params
      params.require(:coffee_shop).permit(:name, :shop_url, :address, :tell, :access, :business_start_hour, :business_end_hour, :regular_holiday, :instagram_url, :instagram_spot_url, :municipalitie_id, :first_image_url, :second_image_url, :third_image_url, images: [])
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
      hash
    end
    
    def set_coffee_shop_search_conditions(hash)
      @coffee_shop_search_conditions = []
      @coffee_shop_search_conditions << "店舗名：#{params[:name]}" if params[:name].present?
      @coffee_shop_search_conditions << "電話番号：#{params[:tel]}" if params[:tell].present?
      if params[:search_category_ids].present?
        search_categorys = SearchCategory.where(id: params[:search_category_ids])
        return_message = "こだわり："
        search_categorys.each do |search_category|
          return_message << "#{search_category.name} "
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
        shop_atmospheres.each do |shop_atmospere|
          return_message << "#{shop_atmospere.name}"
        end
        @coffee_shop_search_conditions << return_message
      end
      if params[:coffee_bean_ids].present?
        coffee_beans = CoffeeBean.where(id: params[:coffee_bean_ids])
        return_message = "コーヒー豆："
        coffee_beans.each do |coffee_bean|
          return_message << "#{coffee_bean.name}"
        end
        @coffee_shop_search_conditions << return_message
      end
      if params[:shop_seats].present?
        @coffee_shop_search_conditions << "席数：#{params[:shop_seats]}席以上" if params[:shop_seats_search_type].eql?("more_than") 
        @coffee_shop_search_conditions << "席数：#{params[:shop_seats]}席以下" if params[:shop_seats_search_type].eql?("less_than")
      end
    end
end
