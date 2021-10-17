class AddUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :string
    add_column :users, :gender, :string
    add_column :users, :self_introduction, :string
    add_column :users, :image, :string
    add_column :users, :instagram_url, :string
  end
end