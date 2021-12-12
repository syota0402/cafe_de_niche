class AddPcWork < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :pc_work, :string
  end
end
