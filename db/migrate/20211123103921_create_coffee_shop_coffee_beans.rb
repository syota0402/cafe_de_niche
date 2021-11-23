class CreateCoffeeShopCoffeeBeans < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_coffee_beans do |t|
      t.integer :coffee_shop_id
      t.integer :coffee_bean_id

      t.timestamps
    end
  end
end
