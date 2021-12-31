class CreateCoffeeShopChairTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_chair_types do |t|
      t.integer :coffee_shop_id
      t.integer :chair_type_id

      t.timestamps
    end
  end
end
