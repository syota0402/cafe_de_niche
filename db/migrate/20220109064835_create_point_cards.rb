class CreatePointCards < ActiveRecord::Migration[5.2]
  def change
    create_table :point_cards do |t|
      t.string :name

      t.timestamps
    end
  end
end
