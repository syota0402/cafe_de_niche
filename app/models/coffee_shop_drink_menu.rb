class CoffeeShopDrinkMenu < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :drink_menu
end
