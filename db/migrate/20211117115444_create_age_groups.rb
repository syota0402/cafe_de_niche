class CreateAgeGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :age_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
