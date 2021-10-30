class CoffeeShopsController < ApplicationController
  def index
    @coffee_shops = CoffeeShop.all
  end

  def show
    @coffee_shop = CoffeeShop.find(params[:id])
    @reviews = @coffee_shop.reviews
    @review = Review.new
    # 店舗のレビューの平均点を計算
    @review_average_score = ReviewAverageScoreService.new(@reviews).calculation
  end

  def new
    @coffee_shop = CoffeeShop.new
  end

  def create
    @coffee_shop = CoffeeShop.new(coffee_shop_params)
    if @coffee_shop.save
      redirect_to coffee_shop_url @coffee_shop, notice: '登録完了'
    else
      flash[:alert] = @coffee_shop.errors.full_messages
      redirect_back(fallback_location: new_coffee_shop_path)
    end
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
    @coffee_shop_search_service = CoffeeShopSearchService.new(params[:name],params[:tell],params[:search_category_ids],params[:review_score],params[:review_score_search_type])
    @coffee_shops = @coffee_shop_search_service.search
  end
  
  private
    def coffee_shop_params
      params.require(:coffee_shop).permit(:name, :shop_url, :address, :tell, :access, :business_start_hour, :business_end_hour, :regular_holiday, :instagram_url, :instagram_spot_url, :municipalitie_id, :first_image_url, :second_image_url, :third_image_url)
    end
end
