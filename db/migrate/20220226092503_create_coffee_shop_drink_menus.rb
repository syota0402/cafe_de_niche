class CreateCoffeeShopDrinkMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_drink_menus do |t|
      t.integer :coffee_shop_id
      t.integer :drink_menu_id

      t.timestamps
    end
  end
end
