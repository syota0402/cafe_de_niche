class Addtakeout < ActiveRecord::Migration[5.2]
  def change
    add_column :coffee_shops, :take_out, :integer
    add_column :coffee_shops, :with_children, :integer
    add_column :coffee_shops, :have_insta_account, :integer
    add_column :coffee_shops, :amusement, :integer
    add_column :coffee_shops, :look_by_instagram, :integer
  end
end
