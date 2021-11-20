class CreateCoffeeShopShopAtmosphere < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_shop_atmospheres do |t|
      t.integer :coffee_shop_id
      t.integer :shop_atmosphere_id
      
      t.timestamps
    end
  end
end
