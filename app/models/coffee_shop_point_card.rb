class CoffeeShopPointCard < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :point_card
end