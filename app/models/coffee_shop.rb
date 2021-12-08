class CoffeeShop < ApplicationRecord
	has_many :coffee_shop_search_categories, dependent: :destroy
	
	has_many :search_categories, :through => :coffee_shop_search_categories
	has_many :reviews, dependent: :destroy
	
	has_many :coffee_shop_shop_atmospheres, dependent: :destroy
	has_many :shop_atmospheres, :through => :coffee_shop_shop_atmospheres
	
	has_many :coffee_shop_coffee_beans, dependent: :destroy
	has_many :coffee_beans, :through => :coffee_shop_coffee_beans
	
	has_many :coffee_shop_volume_in_shops, dependent: :destroy
	has_many :volume_in_shops, :through => :coffee_shop_volume_in_shops
	
	has_many :coffee_shop_food_menus, dependent: :destroy
	has_many :food_menus, :through => :coffee_shop_food_menus
	
	accepts_nested_attributes_for :coffee_shop_search_categories, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_shop_atmospheres, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_coffee_beans, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_volume_in_shops, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_food_menus, allow_destroy: true
	acts_as_likeable
	has_many_attached :images
	
	# バリデーション
	# 必ず登録してほしい項目
	validates :name, :address, :shop_tell, :municipalitie_id, :regular_holiday, presence: true
	
	# 重複チェック
	validates :shop_tell, uniqueness: true
	
	# 電話番号チェック
	validates :shop_tell, presence: true, format: { with: /\A\d{10,11}\z/ }
	
	# 文字数
	validates :name, length: { maximum: 30 }
	validates :shop_url, length: { maximum: 2048 }
	validates :address, length: { maximum: 300 }
	validates :shop_tell, length: { maximum: 11 }
	validates :access, length: { maximum: 100 }
	validates :regular_holiday, length: { maximum: 14 }
	validates :instagram_url, length: { maximum: 2048 }
	validates :instagram_spot_url, length: { maximum: 2048 }
	validates :municipalitie_id, length: { maximum: 1000 }
	
	validate :image_length
	
	# 開始時間と終了時間
	validate :business_start_hour_and_business_end_hour_must_be_set
	validate :slack_time_start_and_slack_time_end_must_be_set
	
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
	
	def business_start_hour_and_business_end_hour_must_be_set
		return if business_start_hour.nil? && business_end_hour.nil?
		
		if business_start_hour.nil?
			errors.add(:business_start_hour, "は営業終了時間とペアで入力してください。")
		elsif	business_end_hour.nil?
			errors.add(:business_end_hour, "は営業開始時間とペアで入力してください。")
		end
	end
	
	def slack_time_start_and_slack_time_end_must_be_set
		return if slack_time_start.nil? && slack_time_end.nil?
		
		if slack_time_start.nil?
			errors.add(:slack_time_start, "はすいている時間(終了)とペアで入力してください。")
		elsif	slack_time_end.nil?
			errors.add(:slack_time_end, "はすいている時間(開始)とペアで入力してください。")
		end
	end
	
end