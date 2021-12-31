class CoffeeShopChairType < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :chair_type
end
