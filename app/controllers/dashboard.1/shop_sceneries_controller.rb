class Dashboard::ShopSceneriesController < ApplicationController
  before_action :set_shop_scenery, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @shop_sceneries = ShopScenery.all
    @shop_scenery = ShopScenery.new
  end
  
  def show
  end
  
  def create
    @shop_scenery = ShopScenery.new(shop_scenery_params)
    if @shop_scenery.save
      redirect_to dashboard_shop_sceneries_path, notice: '登録完了'
    else
      flash[:alert] = @shop_scenery.errors.full_messages
      redirect_back(fallback_location: dashboard_shop_sceneries_path)
    end
  end
  
  def edit
  end
  
  def update
    if @shop_scenery.update(shop_scenery_params)
      redirect_to dashboard_shop_sceneries_path, notice: '変更完了'
    else
      flash[:alert] = @shop_scenery.errors.full_messages
      redirect_back(fallback_location: dashboard_shop_sceneries_path)
    end
  end
  
  def destroy
    @shop_scenery.destroy
    redirect_to dashboard_shop_sceneries_path
  end
  
  private
  
  def set_shop_scenery
    @shop_scenery = ShopScenery.find(params[:id])
  end
  
  def shop_scenery_params
    params.require(:shop_scenery).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "権限がありません"
      redirect_to dashboard_path
    end
  end
  
end