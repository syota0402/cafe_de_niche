class CoffeeShop < ApplicationRecord
	has_many :coffee_shop_search_categories, dependent: :destroy
	has_many :search_categories, :through => :coffee_shop_search_categories
	has_many :reviews, dependent: :destroy
	has_many :coffee_shop_shop_atmospheres, dependent: :destroy
	has_many :shop_atmospheres, :through => :coffee_shop_shop_atmospheres
	has_many :coffee_shop_coffee_beans, dependent: :destroy
	has_many :coffee_beans, :through => :coffee_shop_coffee_beans
	
	accepts_nested_attributes_for :coffee_shop_search_categories, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_shop_atmospheres, allow_destroy: true
	acts_as_likeable
	has_many_attached :images
	
	# バリデーション
	# 必ず登録してほしい項目
	validates :name, :address, :tell, :municipalitie_id, :regular_holiday, presence: true
	
	# 重複チェック
	validates :tell, uniqueness: true
	
	# 電話番号チェック
	validates :tell, presence: true, format: { with: /\A\d{10,11}\z/ }
	
	validates :tell, numericality: true
	
	# 文字数
	validates :name, length: { maximum: 30 }
	validates :shop_url, length: { maximum: 2048 }
	validates :address, length: { maximum: 300 }
	validates :tell, length: { maximum: 11 }
	validates :access, length: { maximum: 100 }
	validates :regular_holiday, length: { maximum: 14 }
	validates :instagram_url, length: { maximum: 2048 }
	validates :instagram_spot_url, length: { maximum: 2048 }
	validates :municipalitie_id, length: { maximum: 1000 }
	
	validate :image_length
	
	scope :search_for_name_and_tell, -> (keyword) {
		where("name LIKE ?", "%#{keyword}%").
		or(where(tell: keyword.to_i))
	}
	
	def review_new
		reviews.new
	end
	
	private

  def image_length
    if images.length >= 4
      errors.add(:images, "は3枚以内にしてください")
    end
  end
	
end