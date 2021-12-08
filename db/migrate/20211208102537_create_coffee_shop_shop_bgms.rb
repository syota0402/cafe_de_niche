class CreateCoffeeShopShopBgms < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_shop_bgms do |t|
      t.integer :coffee_shop_id
      t.integer :shop_bgm_id

      t.timestamps
    end
  end
end
