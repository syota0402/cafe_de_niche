class CreateCoffeeShopAtmosphereOfClerks < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_atmosphere_of_clerks do |t|
      t.integer :coffee_shop_id
      t.integer :atmosphere_of_clerk_id

      t.timestamps
    end
  end
end
