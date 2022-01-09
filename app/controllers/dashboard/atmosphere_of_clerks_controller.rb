class Dashboard::AtmosphereOfClerksController < ApplicationController
  before_action :set_atmosphere_of_clerk, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @atmosphere_of_clerks = AtmosphereOfClerk.all
    @atmosphere_of_clerk = AtmosphereOfClerk.new
  end
  
  def create
    @atmosphere_of_clerk = AtmosphereOfClerk.new(atmosphere_of_clerk_params)
    if @atmosphere_of_clerk.save
      redirect_to dashboard_atmosphere_of_clerks_path, notice: '登録が完了しました'
    else
      flash[:alert] = @atmosphere_of_clerk.errors.full_messages
      redirect_back(fallback_location: dashboard_atmosphere_of_clerks_path)
    end
  end
  
  def edit
  end
  
  def update
    if @atmosphere_of_clerk.update(atmosphere_of_clerk_params)
      redirect_to dashboard_atmosphere_of_clerks_path, notice: '変更が完了しました。'
    else
      flash[:alert] = @atmosphere_of_clerk.errors.full_messages
      redirect_back(fallback_location: dashboard_atmosphere_of_clerks_path)
    end
  end
  
  def destroy
    @atmosphere_of_clerk.destroy
    redirect_to dashboard_atmosphere_of_clerks_path
  end
  
  private
  
  def set_atmosphere_of_clerk
    @atmosphere_of_clerk = AtmosphereOfClerk.find(params[:id])
  end
  
  def atmosphere_of_clerk_params
    params.require(:atmosphere_of_clerk).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "アクセス権限がないです。"
      redirect_to dashboard_path
    end
  end
  
end