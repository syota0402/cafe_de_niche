class AddReserve < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :reservation, :integer
  end
end
