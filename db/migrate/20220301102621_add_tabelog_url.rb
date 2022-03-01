class AddTabelogUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :tabelog_url, :string
  end
end
