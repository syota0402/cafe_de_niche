class CreateCoffeeShopSearchCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shop_search_categories do |t|
      t.integer :coffee_shop_id
      t.integer :search_category_id
      
      t.timestamps
    end
  end
end
