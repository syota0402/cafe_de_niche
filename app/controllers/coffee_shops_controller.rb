class CoffeeShopsController < ApplicationController
  def index
    @coffee_shops = CoffeeShop.all
  end

  def show
  end

  def new
    @coffee_shop = CoffeeShop.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
