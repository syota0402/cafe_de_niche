class CreateCoffeeShops < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shops do |t|
      t.string :name
      t.string :shop_url
      t.string :address
      t.integer :tell
      t.string :access
      t.time :business_start_hour
      t.time :business_end_hour
      t.string :regular_holiday
      t.string :instagram_url
      t.string :instagram_spot_url
      t.integer :municipalitie_id
      t.string :first_image_url
      t.string :second_image_url
      t.string :third_image_url
      
      t.timestamps
    end
  end
end
