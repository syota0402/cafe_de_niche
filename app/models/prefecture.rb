class Prefecture < ApplicationRecord
  has_many :municipalities
  
  validates :name, presence: true
end
