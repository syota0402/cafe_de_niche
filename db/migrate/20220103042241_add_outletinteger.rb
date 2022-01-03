class AddOutletinteger < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :outlet, :integer
  end
end
