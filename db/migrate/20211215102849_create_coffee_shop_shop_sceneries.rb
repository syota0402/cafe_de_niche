class CreateCoffeeShopShopSceneries < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_shop_sceneries do |t|
      t.integer :coffee_shop_id
      t.integer :shop_scenery_id

      t.timestamps
    end
  end
end
