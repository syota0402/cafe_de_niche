class Dashboard::UseScenesController < ApplicationController
  before_action :set_use_scene, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @use_scenes = UseScene.all
    @use_scene = UseScene.new
  end
  
  def show
  end
  
  def create
    @use_scene = UseScene.new(use_scene_params)
    if @use_scene.save
      redirect_to dashboard_use_scenes_path, notice: '登録完了'
    else
      flash[:alert] = @use_scene.errors.full_messages
      redirect_back(fallback_location: dashboard_use_scenes_path)
    end
  end
  
  def edit
  end
  
  def update
    if @use_scene.update(use_scene_params)
      redirect_to dashboard_use_scenes_path, notice: '変更完了'
    else
      flash[:alert] = @use_scene.errors.full_messages
      redirect_back(fallback_location: dashboard_use_scenes_path)
    end
  end
  
  def destroy
    @use_scene.destroy
    redirect_to dashboard_use_scenes_path
  end
  
  private
  
  def set_use_scene
    @use_scene = UseScene.find(params[:id])
  end
  
  def use_scene_params
    params.require(:use_scene).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "権限がありません"
      redirect_to dashboard_path
    end
  end
end
