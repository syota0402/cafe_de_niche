class CreateAtmosphereOfClerks < ActiveRecord::Migration[5.2]
  def change
    create_table :atmosphere_of_clerks do |t|
      t.string :name

      t.timestamps
    end
  end
end
