class WebController < ApplicationController
  def index
  end
  
  def search
    @municipalities = Municipality.where(prefecture_id: params[:prefecture_id])
  end
end
