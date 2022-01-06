class AtmosphereOfClerk < ApplicationRecord
  has_many :coffee_shop_atmosphere_of_clerks, dependent: :destroy
  has_many :coffee_shops, :through => :coffee_shop_atmosphere_of_clerks
  
  #空白禁止
  validates :name, presence: true
  
  # 重複禁止
	validates :name, uniqueness: true
	
	# 文字数
	validates :name, length: { maximum: 15}
end
