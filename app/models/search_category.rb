class SearchCategory < ApplicationRecord
  has_many :coffee_shop_search_categories, dependent: :destroy
  has_many :coffee_shops, :through => :coffee_shop_search_categories
end
