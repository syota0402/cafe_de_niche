class CreateShopSceneries < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_sceneries do |t|
      t.string :name
      t.timestamps
    end
  end
end
