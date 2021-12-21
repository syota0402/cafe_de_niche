class Dashboard::ShopBgmsController < ApplicationController
  before_action :set_shop_bgm, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @shop_bgms = ShopBgm.all
    @shop_bgm = ShopBgm.new
  end
  
  def show
  end
  
  def create
    @shop_bgm = ShopBgm.new(shop_bgm_params)
    if @shop_bgm.save
      redirect_to dashboard_shop_bgms_path, notice: '登録完了'
    else
      flash[:alert] = @shop_bgm.errors.full_messages
      redirect_back(fallback_location: dashboard_shop_bgms_path)
    end
  end
  
  def edit
  end
  
  def update
    if @shop_bgm.update(shop_bgm_params)
      redirect_to dashboard_shop_bgms_path, notice: '変更完了'
    else
      flash[:alert] = @shop_bgm.errors.full_messages
      redirect_back(fallback_location: dashboard_shop_bgms_path)
    end
  end
  
  def destroy
    @shop_bgm.destroy
    redirect_to dashboard_shop_bgms_path
  end
  
  private
  
  def set_shop_bgm
    @shop_bgm = ShopBgm.find(params[:id])
  end
  
  def shop_bgm_params
    params.require(:shop_bgm).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "権限がありません"
      redirect_to dashboard_path
    end
  end
  
end