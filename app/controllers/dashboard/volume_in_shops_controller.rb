class Dashboard::VolumeInShopsController < ApplicationController
  before_action :set_volume_in_shop, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @volume_in_shops = VolumeInShop.all
    @volume_in_shop = VolumeInShop.new
  end
  
  def show
  end
  
  def create
    @volume_in_shop = VolumeInShop.new(volume_in_shop_params)
    if @volume_in_shop.save
      redirect_to dashboard_volume_in_shops_path, notice: '登録完了'
    else
      flash[:alert] = @volume_in_shop.errors.full_messages
      redirect_back(fallback_location: dashboard_volume_in_shops_path)
    end
  end
  
  def edit
  end
  
  def update
    if @volume_in_shop.update(volume_in_shop_params)
      redirect_to dashboard_volume_in_shops_path, notice: '変更完了'
    else
      flash[:alert] = @volume_in_shop.errors.full_messages
      redirect_back(fallback_location: dashboard_volume_in_shops_path)
    end
  end
  
  def destroy
    @volume_in_shop.destroy
    redirect_to dashboard_volume_in_shops_path
  end
  
  private
  
  def set_volume_in_shop
    @volume_in_shop = VolumeInShop.find(params[:id])
  end
  
  def volume_in_shop_params
    params.require(:volume_in_shop).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "権限がありません"
      redirect_to dashboard_path
    end
  end
end