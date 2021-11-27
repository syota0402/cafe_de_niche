class CoffeeShopFoodMenu < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :food_menu
end
