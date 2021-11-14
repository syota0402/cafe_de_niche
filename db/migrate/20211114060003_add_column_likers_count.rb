class AddColumnLikersCount < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :likees_count, :integer, :default => 0
  end
end
