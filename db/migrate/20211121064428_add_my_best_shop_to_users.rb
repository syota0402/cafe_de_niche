class AddMyBestShopToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :best_shop_id, :integer
  end
end
