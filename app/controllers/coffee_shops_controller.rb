class CoffeeShopsController < ApplicationController
  def index
    @coffee_shops = CoffeeShop.all
  end

  def show
    @coffee_shop = CoffeeShop.find(params[:id])
  end

  def new
    @coffee_shop = CoffeeShop.new
  end

  def create
    @coffee_shop = CoffeeShop.new(coffee_shop_params)
    @coffee_shop.save
    redirect_to coffee_shop_url @coffee_shop
    # バリデーションエラーでメッセージを出したい
    # if @coffee_shop.save
    #   redirect_to coffee_shop_url @coffee_shop
    # else
    #   render @coffee_shop.new
    # end
  end

  def edit
    @coffee_shop = CoffeeShop.find(params[:id])
  end

  def update
    @coffee_shop = CoffeeShop.find(params[:id])
    @coffee_shop.update(coffee_shop_params)
    redirect_to coffee_shop_url @coffee_shop
  end

  def destroy
    @coffee_shop = CoffeeShop.find(params[:id])
    @coffee_shop.destroy
    redirect_to coffee_shops_path
  end
  
  def search
    # 店舗名　一部一致
    if params[:name].present?
      @coffee_shops = CoffeeShop.where('name LIKE ?', "%#{params[:name]}%")
    # 電話番号　完全一致
    elsif params[:tell].present?
      @coffee_shops = CoffeeShop.where(tell: params[:tell])
    else
      @coffee_shops = CoffeeShop.none
    end
  end
  
  private
    def coffee_shop_params
      params.require(:coffee_shop).permit(:name, :shop_url, :address, :tell, :access, :business_start_hour, :business_end_hour, :regular_holiday, :instagram_url, :instagram_spot_url, :municipalitie_id, :first_image_url, :second_image_url, :third_image_url)
    end
end
