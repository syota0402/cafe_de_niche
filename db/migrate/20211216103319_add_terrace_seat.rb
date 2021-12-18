class AddTerraceSeat < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :terrace_seat, :string
    add_column :coffee_shops, :can_reserved, :string
    add_column :coffee_shops, :comic, :string
    add_column :coffee_shops, :magazine, :string
    add_column :coffee_shops, :latte_art, :string
    add_column :coffee_shops, :newspaper, :string
    add_column :coffee_shops, :morning_menu, :string
    add_column :coffee_shops, :parking_place, :string
    add_column :coffee_shops, :free_water, :string
    add_column :coffee_shops, :with_pet, :string
    add_column :coffee_shops, :free_pc, :string
  end
end