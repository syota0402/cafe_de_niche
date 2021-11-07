class Municipality < ApplicationRecord
  belongs_to :prefecture
  
  validates :name, :prefecture_id, presence: true
end
