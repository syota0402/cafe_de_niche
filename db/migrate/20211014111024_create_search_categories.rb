class CreateSearchCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_categories do |t|

      t.timestamps
    end
  end
end
