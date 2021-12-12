class CreatePcWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :pc_works do |t|
      t.string :name

      t.timestamps
    end
  end
end
