class Dashboard::PrefecturesController < ApplicationController
  before_action :set_prefecture, only: %w[edit update destroy]
  layout "dashboard/dashboard"
  
  def index
    @prefectures = Prefecture.all
    @prefecture = Prefecture.new
  end
  
  def show
  end
  
  def create
    @prefecture = Prefecture.new(prefecture_params)
    @prefecture.save
    redirect_to dashboard_prefectures_path
  end
  
  def edit
  end
  
  def update
    @prefecture.update(prefecture_params)
    redirect_to dashboard_prefectures_path
  end
  
  def destroy
    @prefecture.destroy
    redirect_to dashboard_prefectures_path
  end
  
  private
  
  def set_prefecture
    @prefecture = Prefecture.find(params[:id])
  end
  
  def prefecture_params
    params.require(:prefecture).permit(:name)
  end
  
end
