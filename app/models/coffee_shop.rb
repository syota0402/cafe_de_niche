class CoffeeShop < ApplicationRecord
	# バリデーション
	# 必ず登録してほしい項目
	validates :name, :address, :tell, presence: true
	
	# 重複チェック
	validates :shop_url, :tell, uniqueness: true
	
	# 電話番号チェック
	validates :tell, format: { with: /\A\d{10,11}\z/ }
	validates :tell, numericality: true
	
	# URLチェック
	validates :shop_url, :instagram_url, :instagram_spot_url, format: /\A#{URI::regexp(%w(http https))}\z/
	
	# 時間チェック
	# validates　:business_start_hour, :business_end_hour,
	
	# 文字数
	validates :name, length: { maximum: 30}
	validates :shop_url, length: { maximum: 100}
	validates :address, length: { maximum: 100}
	validates :tell, length: { maximum: 11}
	validates :access, length: { maximum: 100}
	validates :business_start_hour, length: { maximum: 6}
	validates :business_end_hour, length: { maximum: 6}
	validates :regular_holiday, length: { maximum: 14}
	validates :instagram_url, length: { maximum: 100}
	validates :instagram_spot_url, length: { maximum: 100}
	validates :municipalitie_id, length: { maximum: 100}
	validates :first_image_url, length: { maximum: 100}
	validates :second_image_url, length: { maximum: 100}
	validates :third_image_url, length: { maximum: 100}
	
end