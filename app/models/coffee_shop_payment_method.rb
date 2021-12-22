class CoffeeShopPaymentMethod < ApplicationRecord
  belongs_to :coffee_shop
  belongs_to :payment_method
end
