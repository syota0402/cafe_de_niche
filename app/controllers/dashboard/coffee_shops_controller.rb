class Dashboard::CoffeeShopsController < ApplicationController
  before_action :set_coffee_shop, only: %w[show edit update destroy]
  before_action :check_user_authority, only: :destroy
  layout "dashboard/dashboard"
  PER = 15
  
  def index
    if params[:keyword].present?
      keyword = params[:keyword].strip
      @total_count = CoffeeShop.search_for_name_and_tell(keyword).count
      @coffee_shops = CoffeeShop.search_for_name_and_tell(keyword).order("created_at DESC").page(params[:page]).per(PER)
    else
      @total_count = CoffeeShop.count
      @coffee_shops = CoffeeShop.order("created_at DESC").page(params[:page]).per(PER)
    end
  end
  
  def show
  end

  def new
    @coffee_shop = CoffeeShop.new
    set_municipality_tags
  end

  def create
    @coffee_shop = CoffeeShop.new(coffee_shop_params.merge(regular_holiday: params[:regular_holidays]&.join(',')))
    if @coffee_shop.save
      redirect_to dashboard_coffee_shops_path, notice: '登録完了'
    else
      flash[:alert] = @coffee_shop.errors.full_messages
      redirect_back(fallback_location: new_dashboard_coffee_shop_path)
    end
  end

  def edit
    set_municipality_tags
  end

  def update
    if coffee_shop_params[:images].present?
      @coffee_shop.images.purge
    end
    if @coffee_shop.update(coffee_shop_params.merge(regular_holiday: params[:regular_holidays]&.join(',')))
      redirect_to dashboard_coffee_shops_url, notice: '登録完了'
    else
      flash[:alert] = @coffee_shop.errors.full_messages
      redirect_back(fallback_location: edit_dashboard_coffee_shop_path)
    end
  end

  def destroy
    @coffee_shop.destroy
    delete_user_best_shop
    redirect_to dashboard_coffee_shops_url
  end
  
  private
  def set_coffee_shop
    @coffee_shop = CoffeeShop.find(params[:id])
  end
    
  def set_municipality_tags
    municipalities = Municipality.all
    @municipality_tags = []
    municipalities.each do |municipality|
      @municipality_tags << [municipality.name, municipality.id]
    end
  end
  
  def coffee_shop_params
    params.require(:coffee_shop).permit(:name, :shop_url, :address, :shop_tell, :access, :business_start_hour, :business_end_hour, :instagram_url, :instagram_spot_url, :municipalitie_id, :slack_time_start, :slack_time_end, :age_group, :shop_seats, :pc_work, :time_limit, :terrace_seat, :can_reserved, :comic, :magazine, :latte_art, :newspaper, :morning_menu, :parking_place, :free_water, :with_pet, :free_pc, :shop_badget_upper, :shop_badget_lower, :coffee_price, :latte_price, :outlet, :wifi, :smoking, 
    { :search_category_ids => [], :shop_atmosphere_ids => [], :coffee_bean_ids => [], :volume_in_shop_ids => [], :food_menu_ids => [], :shop_bgm_ids => [], :shop_scenery_ids => [], :payment_method_ids => [], :chair_type_ids => [], :use_scene_ids => [] }, images: [])
  end
  
  def check_user_authority
		@user = current_user
		if @user.authority.eql?("2")
			flash[:alert] = "権限がありません"
			redirect_to dashboard_path 
		end
  end
  
  def delete_user_best_shop
    users = User.where(best_shop_id: @coffee_shop.id) 
    users.each do |user|
      user.update(best_shop_id: "")
    end
  end
  
end
