class Dashboard::ChairTypesController < ApplicationController
  before_action :set_chair_type, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @chair_types = ChairType.all
    @chair_type = ChairType.new
  end
  
  def show
  end
  
  def create
    @chair_type = ChairType.new(chair_type_params)
    if @chair_type.save
      redirect_to dashboard_chair_types_path, notice: '登録が完了しました'
    else
      flash[:alert] = @chair_type.errors.full_messages
      redirect_back(fallback_location: dashboard_chair_types_path)
    end
  end
  
  def edit
  end
  
  def update
    if @chair_type.update(chair_type_params)
      redirect_to dashboard_chair_types_path, notice: '変更が完了しました。'
    else
      flash[:alert] = @chair_type.errors.full_messages
      redirect_back(fallback_location: dashboard_chair_types_path)
    end
  end
  
  def destroy
    @chair_type.destroy
    redirect_to dashboard_chair_types_path
  end
  
  private
  
  def set_chair_type
    @chair_type = ChairType.find(params[:id])
  end
  
  def chair_type_params
    params.require(:chair_type).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "アクセス権限がないです。"
      redirect_to dashboard_path
    end
  end
  
end