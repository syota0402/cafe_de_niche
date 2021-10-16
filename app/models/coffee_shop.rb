class CoffeeShop < ApplicationRecord
	has_many :coffee_shop_search_categories, dependent: :destroy
	has_many :search_categories, :through => :coffee_shop_search_categories
	
	accepts_nested_attributes_for :coffee_shop_search_categories, allow_destroy: true
	
	# バリデーション
	# 必ず登録してほしい項目
	validates :name, :address, :tell, presence: true
	
	# 重複チェック
	validates :tell, uniqueness: true
	
	# 電話番号チェック
	validates :tell, format: { with: /\A\d{10,11}\z/ }
	validates :tell, numericality: true
	
	# 時間チェック
	# validates　:business_start_hour, :business_end_hour,
	
	# 文字数
	validates :name, length: { maximum: 30}
	validates :shop_url, length: { maximum: 2048}
	validates :address, length: { maximum: 300}
	validates :tell, length: { maximum: 11}
	validates :access, length: { maximum: 100}
	validates :business_start_hour, length: { maximum: 6}
	validates :business_end_hour, length: { maximum: 6}
	validates :regular_holiday, length: { maximum: 14}
	validates :instagram_url, length: { maximum: 2048}
	validates :instagram_spot_url, length: { maximum: 2048}
	validates :municipalitie_id, length: { maximum: 1000}
	validates :first_image_url, length: { maximum: 2048}
	validates :second_image_url, length: { maximum: 2048}
	validates :third_image_url, length: { maximum: 2048}
	
	scope :search_for_name_and_tell, -> (keyword) {
		where("name LIKE ?", "%#{keyword}%").
		or(where(tell: keyword.to_i))
	}
end