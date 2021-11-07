class Dashboard::MunicipalitiesController < ApplicationController
  before_action :set_municipality, only: %w[edit update destroy]
  before_action :set_prefecture_tags, only: %w[index edit]
  layout "dashboard/dashboard"
  
  def index
    @municipalities = Municipality.all
    @municipality = Municipality.new
  end
  
  def show
  end
  
  def create
    @municipality = Municipality.new(municipality_params)
    @municipality.save
    redirect_to dashboard_municipalities_path
  end
  
  def edit
  end
  
  def update
    @municipality.update(municipality_params)
    redirect_to dashboard_municipalities_path
  end
  
  def destroy
    @municipality.destroy
    redirect_to dashboard_municipalities_path
  end
  
  private
  
  def set_municipality
    @municipality = Municipality.find(params[:id])
  end
  
  def set_prefecture_tags
    prefectures = Prefecture.all
    @prefecture_tag = []
    prefectures.each do |prefecture|
      @prefecture_tag << [prefecture.name, prefecture.id]
    end
  end
  
  def municipality_params
    params.require(:municipality).permit(:name, :prefecture_id)
  end

end
