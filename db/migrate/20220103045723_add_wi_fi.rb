class AddWiFi < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :wifi, :integer
    add_column :coffee_shops, :smoking, :integer
  end
end
