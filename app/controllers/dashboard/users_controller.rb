class Dashboard::UsersController < ApplicationController
  layout "dashboard/dashboard"
  
  def index
    if params[:keyword].present?
      @keyword = params[:keyword].strip
      @users = User.search_information(@keyword).all
    else
      @users = User.all
    end
  end
  
  def destroy
  end
end
