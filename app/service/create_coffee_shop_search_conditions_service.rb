class CreateCoffeeShopSearchConditionsService
  def initialize(hash)
    @name = hash[:name]
    @tell = hash[:shop_tell]
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
    
    @coffee_shop_search_conditions
  end
  
  def create_name
    @coffee_shop_search_conditions << "店舗名：#{@name}"
  end
  
  def set_coffee_shop_search_conditions(hash)
      @coffee_shop_search_conditions = []
      @coffee_shop_search_conditions << "店舗名：#{params[:name]}" if params[:name].present?
      @coffee_shop_search_conditions << "電話番号：#{params[:tel]}" if params[:tell].present?
      if params[:search_category_ids].present?
        search_categorys = SearchCategory.where(id: params[:search_category_ids])
        return_message = "こだわり：#{search_categorys.pluck(:name).join('or')}"
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