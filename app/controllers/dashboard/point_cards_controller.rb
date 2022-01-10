class Dashboard::PointCardsController < ApplicationController
  before_action :set_point_card, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @point_cards = PointCard.all
    @point_card = PointCard.new
  end
  
  def create
    @point_card = PointCard.new(point_card_params)
    if @point_card.save
      redirect_to dashboard_point_cards_path, notice: '登録が完了しました'
    else
      flash[:alert] = @point_card.errors.full_messages
      redirect_back(fallback_location: dashboard_point_cards_path)
    end
  end
  
  def edit
  end
  
  def update
    if @point_card.update(point_card_params)
      redirect_to dashboard_point_cards_path, notice: '変更が完了しました。'
    else
      flash[:alert] = @point_card.errors.full_messages
      redirect_back(fallback_location: dashboard_point_cards_path)
    end
  end
  
  def destroy
    @point_card.destroy
    redirect_to dashboard_point_cards_path
  end
  
  private
  
  def set_point_card
    @point_card = PointCard.find(params[:id])
  end
  
  def point_card_params
    params.require(:point_card).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "アクセス権限がないです。"
      redirect_to dashboard_path
    end
  end
  
end