class Addtellsecret < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :tell_secret, :boolean
  end
end
