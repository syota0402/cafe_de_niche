class CreateUsescenes < ActiveRecord::Migration[5.2]
  def change
    create_table :use_scenes do |t|
      t.string :name

      t.timestamps
    end
  end
end
