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
  end

  def create
    @coffee_shop = CoffeeShop.new(coffee_shop_params)
    @coffee_shop.save
    redirect_to dashboard_coffee_shops_url
  end

  def edit
  end

  def update
    @coffee_shop.update(coffee_shop_params)
    redirect_to dashboard_coffee_shops_url
  end

  def destroy
    @coffee_shop.destroy
    redirect_to dashboard_coffee_shops_url
  end
  
  private
    def set_coffee_shop
      @coffee_shop = CoffeeShop.find(params[:id])
    end
end
