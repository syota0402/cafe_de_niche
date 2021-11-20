class AddSlackTime < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :slack_time_start, :time
    add_column :coffee_shops, :slack_time_end, :time
  end
end
