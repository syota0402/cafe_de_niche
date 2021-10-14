class CoffeeShopSearchCategory < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :search_category
end
