class Dashboard::CoffeeShopsController < ApplicationController
  before_action :set_coffee_shop, only: %w[show edit update destroy]
  layout "dashboard/dashboard"
  
  def index
    if params[:keyword].present?
      keyword = params[:keyword].strip
      @total_count = CoffeeShop.search_for_name_and_tell(keyword).count
      @coffee_shops = CoffeeShop.search_for_name_and_tell(keyword)
    else
      @total_count = CoffeeShop.count
      @coffee_shops = CoffeeShop.all
    end
  end
  
  def show
  end

  def new
    @coffee_shop = CoffeeShop.new
    @search_categories = SearchCategory.all
  end

  def create
    @coffee_shop = CoffeeShop.new(coffee_shop_params)
    if @coffee_shop.save
      redirect_to dashboard_coffee_shops_path, notice: '登録完了'
    else
      flash[:alert] = @coffee_shop.errors.full_messages
      redirect_back(fallback_location: new_dashboard_coffee_shop_path)
    end
  end

  def edit
  end

  def update
    if @coffee_shop.update(coffee_shop_params)
      redirect_to dashboard_coffee_shops_url, notice: '登録完了'
    else
      flash[:alert] = @coffee_shop.errors.full_messages
      redirect_back(fallback_location: edit_dashboard_coffee_shop_path)
    end
  end

  def destroy
    @coffee_shop.destroy
    redirect_to dashboard_coffee_shops_url
  end
  
  private
    def set_coffee_shop
      @coffee_shop = CoffeeShop.find(params[:id])
    end
    
    def coffee_shop_params
      params.require(:coffee_shop).permit(:name, :shop_url, :address, :tell, :access, :business_start_hour, :business_end_hour, :regular_holiday, :instagram_url, :instagram_spot_url, :municipalitie_id, {:search_category_ids => []}, :image)
    end
end
