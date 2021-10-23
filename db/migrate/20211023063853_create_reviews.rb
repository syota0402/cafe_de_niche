class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :coffee_shop, foreign_key: true
      t.text :review_comment
      t.string :review_pictuer
      t.integer :review_score
      t.timestamps
    end
  end
end
