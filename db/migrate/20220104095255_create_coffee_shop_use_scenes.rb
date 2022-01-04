class CreateCoffeeShopUseScenes < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_use_scenes do |t|
      t.integer :coffee_shop_id
      t.integer :use_scene_id
      
      t.timestamps
    end
  end
end
