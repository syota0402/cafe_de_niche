class Municipality < ApplicationRecord
  belongs_to :prefecture
  
  validates :name, :prefecture_id, presence: true
  
  scope :search_for_eria_name, -> (keyword) {
    where("name LIKE ?", "%#{keyword}%")
  }
  
end
