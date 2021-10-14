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
    @search_category.save
    redirect_to dashboard_search_categories_path
  end
  
  def edit
  end
  
  def update
    @search_category.update(search_category_params)
    @search_category.save
    redirect_to dashboard_search_categories_path
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
