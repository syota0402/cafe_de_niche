class CreateDrinkMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :drink_menus do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
