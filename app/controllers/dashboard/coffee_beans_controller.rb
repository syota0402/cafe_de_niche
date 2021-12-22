class Dashboard::CoffeeBeansController < ApplicationController
  before_action :set_coffee_bean, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @coffee_beans = CoffeeBean.all
    @coffee_bean = CoffeeBean.new
  end
  
  def show
  end
  
  def create
    @coffee_bean = CoffeeBean.new(coffee_bean_params)
    if @coffee_bean.save
      redirect_to dashboard_coffee_beans_path, notice: '登録が完了しました'
    else
      flash[:alert] = @coffee_bean.errors.full_messages
      redirect_back(fallback_location: dashboard_coffee_beans_path)
    end
  end
  
  def edit
  end
  
  def update
    if @coffee_bean.update(coffee_bean_params)
      redirect_to dashboard_coffee_beans_path, notice: '変更が完了しました。'
    else
      flash[:alert] = @coffee_bean.errors.full_messages
      redirect_back(fallback_location: dashboard_coffee_beans_path)
    end
  end
  
  def destroy
    @coffee_bean.destroy
    redirect_to dashboard_coffee_beans_path
  end
  
  private
  
  def set_coffee_bean
    @coffee_bean = CoffeeBean.find(params[:id])
  end
  
  def coffee_bean_params
    params.require(:coffee_bean).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "アクセス権限がないです。"
      redirect_to dashboard_path
    end
  end
  
end