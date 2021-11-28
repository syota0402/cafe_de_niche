class Dashboard::FoodMenusController < ApplicationController
  before_action :set_food_menu, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @food_menus = FoodMenu.all
    @food_menu = FoodMenu.new
  end
  
  def show
  end
  
  def create
    @food_menu = FoodMenu.new(food_menu_params)
    if @food_menu.save
      redirect_to dashboard_food_menus_path, notice: '登録完了'
    else
      flash[:alert] = @food_menu.errors.full_messages
      redirect_back(fallback_location: dashboard_food_menus_path)
    end
  end
  
  def edit
  end
  
  def update
    if @food_menu.update(food_menu_params)
      redirect_to dashboard_food_menus_path, notice: '変更完了'
    else
      flash[:alert] = @food_menu.errors.full_messages
      redirect_back(fallback_location: dashboard_food_menus_path)
    end
  end
  
  def destroy
    @food_menu.destroy
    redirect_to dashboard_food_menus_path
  end
  
  private
  
  def set_food_menu
    @food_menu = FoodMenu.find(params[:id])
  end
  
  def food_menu_params
    params.require(:food_menu).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "権限がありません"
      redirect_to dashboard_path
    end
  end
  
end