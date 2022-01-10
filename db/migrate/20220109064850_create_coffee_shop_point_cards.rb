class CreateCoffeeShopPointCards < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_point_cards do |t|
      t.integer :coffee_shop_id
      t.integer :point_card_id

      t.timestamps
    end
  end
end
