class AddColumnLikersCount2 < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :likers_count, :integer, :default => 0
  end
end
