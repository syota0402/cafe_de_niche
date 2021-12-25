class CreateChairTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :chair_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
