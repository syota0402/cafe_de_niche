class Dashboard::SizeOfDesksController < ApplicationController
  before_action :set_size_of_desk, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @size_of_desks = SizeOfDesk.all
    @size_of_desk = SizeOfDesk.new
  end

  def create
    @size_of_desk = SizeOfDesk.new(size_of_desk_params)
    if @size_of_desk.save
      redirect_to dashboard_size_of_desks_path, notice: '登録が完了しました'
    else
      flash[:alert] = @size_of_desk.errors.full_messages
      redirect_back(fallback_location: dashboard_size_of_desks_path)
    end
  end
  
  def edit
  end
  
  def update
    if @size_of_desk.update(size_of_desk_params)
      redirect_to dashboard_size_of_desks_path, notice: '変更が完了しました。'
    else
      flash[:alert] = @size_of_desk.errors.full_messages
      redirect_back(fallback_location: dashboard_size_of_desks_path)
    end
  end
  
  def destroy
    @size_of_desk.destroy
    redirect_to dashboard_size_of_desks_path
  end
  
  private
  
  def set_size_of_desk
    @size_of_desk = SizeOfDesk.find(params[:id])
  end
  
  def size_of_desk_params
    params.require(:size_of_desk).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "アクセス権限がないです。"
      redirect_to dashboard_path
    end
  end
  
end