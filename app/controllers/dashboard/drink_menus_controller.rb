class Dashboard::DrinkMenusController < ApplicationController
  before_action :set_drink_menu, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @drink_menus = DrinkMenu.all
    @drink_menu = DrinkMenu.new
  end
  
  def create
    @drink_menu = DrinkMenu.new(drink_menu_params)
    if @drink_menu.save
      redirect_to dashboard_drink_menus_path, notice: '登録完了'
    else
      flash[:alert] = @drink_menu.errors.full_messages
      redirect_back(fallback_location: dashboard_drink_menus_path)
    end
  end
  
  def edit
  end
  
  def update
    if @drink_menu.update(drink_menu_params)
      redirect_to dashboard_drink_menus_path, notice: '変更完了'
    else
      flash[:alert] = @drink_menu.errors.full_messages
      redirect_back(fallback_location: dashboard_drink_menus_path)
    end
  end
  
  def destroy
    @drink_menu.destroy
    redirect_to dashboard_drink_menus_path
  end
  
  private
  
  def set_drink_menu
    @drink_menu = DrinkMenu.find(params[:id])
  end
  
  def drink_menu_params
    params.require(:drink_menu).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "権限がありません"
      redirect_to dashboard_path
    end
  end
  
end