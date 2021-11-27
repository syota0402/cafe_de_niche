class CreateVolumeInShops < ActiveRecord::Migration[5.2]
  def change
    create_table :volume_in_shops do |t|
      t.string :name

      t.timestamps
    end
  end
end
