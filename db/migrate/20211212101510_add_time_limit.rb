class AddTimeLimit < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :time_limit, :string
  end
end
