class AddOutlet < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :existence_outlet, :string
    add_column :coffee_shops, :existence_wifi, :string
    add_column :coffee_shops, :can_smoking, :string
  end
end
