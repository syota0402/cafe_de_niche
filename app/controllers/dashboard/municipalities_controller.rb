class Dashboard::MunicipalitiesController < ApplicationController
  before_action :set_municipality, only: %w[edit update destroy]
  before_action :set_prefecture_tags, only: %w[index edit]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    # @municipalities = Municipality.all
    if params[:keyword].present?
      keyword = params[:keyword].strip
      @municipalities = Municipality.search_for_eria_name(keyword).page(params[:page]).per(15)
    else
      @municipalities = Municipality.page(params[:page]).per(15)
    end
    @municipality = Municipality.new
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
  
  def check_user_authority
		@user = current_user
		if @user.authority.eql?("2")
			flash[:alert] = "権限がありません"
			redirect_to dashboard_path 
		end
  end

end
