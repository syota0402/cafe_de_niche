class ChangeCoffeeShopsColumns < ActiveRecord::Migration[5.2]
  def up
    add_column :coffee_shops, :shop_seats, :integer
    remove_column :coffee_shops, :first_image_url, :string
    remove_column :coffee_shops, :second_image_url, :string
    remove_column :coffee_shops, :third_image_url, :string
  end

  def down
    remove_column :coffee_shops, :shop_seats, :integer
    add_column :coffee_shops, :first_image_url, :string
    add_column :coffee_shops, :second_image_url, :string
    add_column :coffee_shops, :third_image_url, :string
  end
end
