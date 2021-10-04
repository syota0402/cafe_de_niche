class CoffeeShopsController < ApplicationController
  def index
    @coffee_shops = CoffeeShop.all
  end

  def show
  end

  def new
    @coffee_shop = CoffeeShop.new
  end

  def create
    @coffee_shop = CoffeeShop.new(coffee_shop_params)
    @coffee_shop.save
    redirect_to coffee_shop_url @coffee_shop
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
    def coffee_shop_params
      params.require(:coffee_shop).permit(:name, :shop_url, :address, :tell, :access, :business_start_hour, :business_end_hour, :regular_holiday, :instagram_url, :instagram_spot_url, :municipalitie_id, :first_image_url, :second_image_url, :third_image_url)
    end
end
