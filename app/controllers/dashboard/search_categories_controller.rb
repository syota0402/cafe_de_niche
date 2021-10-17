class Dashboard::SearchCategoriesController < ApplicationController
  before_action :set_search_category, only: %w[show edit update destroy]
  layout "dashboard/dashboard"
  
  def index
    @search_categories = SearchCategory.all
    @search_category = SearchCategory.new
  end
  
  def show
  end
  
  def create
    @search_category = SearchCategory.new(search_category_params)
    if @search_category.save
      redirect_to dashboard_search_categories_path, notice: '登録完了'
    else
      flash[:alert] = @search_category.errors.full_messages
      redirect_back(fallback_location: dashboard_search_categories_path)
    end
  end
  
  def edit
  end
  
  def update
    if @search_category.update(search_category_params)
      redirect_to dashboard_search_categories_path, notice: '変更完了'
    else
      flash[:alert] = @search_category.errors.full_messages
      redirect_back(fallback_location: dashboard_search_categories_path)
    end
  end
  
  def destroy
    @search_category.destroy
    redirect_to dashboard_search_categories_path
  end
  
  private
  
  def set_search_category
    @search_category = SearchCategory.find(params[:id])
  end
  
  def search_category_params
    params.require(:search_category).permit(:name)
  end
end
