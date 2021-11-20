class Dashboard::ShopAtmospheresController < ApplicationController
  before_action :set_shop_atmosphere, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @shop_atmospheres = ShopAtmosphere.all
    @shop_atmosphere = ShopAtmosphere.new
  end
  
  def show
  end
  
  def create
    @shop_atmosphere = ShopAtmosphere.new(shop_atmosphere_params)
    if @shop_atmosphere.save
      redirect_to dashboard_shop_atmospheres_path, notice: '登録完了'
    else
      flash[:alert] = @shop_atmosphere.errors.full_messages
      redirect_back(fallback_location: dashboard_shop_atmospheres_path)
    end
  end
  
  def edit
  end
  
  def update
    if @shop_atmosphere.update(shop_atmosphere_params)
      redirect_to dashboard_shop_atmospheres_path, notice: '変更完了'
    else
      flash[:alert] = @shop_atmosphere.errors.full_messages
      redirect_back(fallback_location: dashboard_shop_atmospheres_path)
    end
  end
  
  def destroy
    binding.pry
    @shop_atmosphere.destroy
    redirect_to dashboard_shop_atmospheres_path
  end
  
  private
  
  def set_shop_atmosphere
    @shop_atmosphere = ShopAtmosphere.find(params[:id])
  end
  
  def shop_atmosphere_params
    params.require(:shop_atmosphere).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "権限がありません"
      redirect_to dashboard_path
    end
  end
  
end