class AddUserSnsLink < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_url, :string
    add_column :users, :youtube_url, :string
    add_column :users, :users_blog_url, :string
    add_column :users, :tabelog_url, :string
    add_column :users, :facebook_url, :string
    add_column :users, :tiktok_url, :string
  end
end
