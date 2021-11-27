class CreateCoffeeShopVolumeInShops < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_volume_in_shops do |t|
      t.integer :coffee_shop_id
      t.integer :volume_in_shop_id

      t.timestamps
    end
  end
end
