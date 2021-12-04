class Addshoptelcolum < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :shop_tell, :string
  end
end
