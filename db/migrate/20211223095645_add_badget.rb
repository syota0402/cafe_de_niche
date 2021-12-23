class AddBadget < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :shop_badget_upper, :integer
    add_column :coffee_shops, :shop_badget_lower, :integer
    add_column :coffee_shops, :coffee_price, :integer
    add_column :coffee_shops, :latte_price, :integer
  end
end
