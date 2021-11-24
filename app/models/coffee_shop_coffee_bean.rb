class CoffeeShopCoffeeBean < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :coffee_bean
end
