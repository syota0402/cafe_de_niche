class AddAgeGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :age_group, :string
  end
end
