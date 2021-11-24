class ChangeCoffeeShopsColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :shop_seats, :string
  end
end
