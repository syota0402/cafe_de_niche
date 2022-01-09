class CreateCoffeeShopSizeOfDesks < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_size_of_desks do |t|
      t.integer :coffee_shop_id
      t.integer :size_of_desk_id

      t.timestamps
    end
  end
end
