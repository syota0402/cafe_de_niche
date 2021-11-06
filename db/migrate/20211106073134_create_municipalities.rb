class CreateMunicipalities < ActiveRecord::Migration[5.2]
  def change
    create_table :municipalities do |t|
      t.string :name
      t.integer :prefecture_id
      t.timestamps
    end
  end
end
