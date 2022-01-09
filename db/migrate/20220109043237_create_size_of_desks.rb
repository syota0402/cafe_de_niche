class CreateSizeOfDesks < ActiveRecord::Migration[5.2]
  def change
    create_table :size_of_desks do |t|
      t.string :name

      t.timestamps
    end
  end
end
