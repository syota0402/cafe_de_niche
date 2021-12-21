class CreateCoffeeShopPaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_payment_methods do |t|
      t.integer :coffee_shop_id
      t.integer :payment_method_id

      t.timestamps
    end
  end
end
