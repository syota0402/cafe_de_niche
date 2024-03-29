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
	
	has_many :coffee_shop_shop_bgms, dependent: :destroy
	has_many :shop_bgms, :through => :coffee_shop_shop_bgms
	
	has_many :coffee_shop_shop_sceneries, dependent: :destroy
	has_many :shop_sceneries, :through => :coffee_shop_shop_sceneries
	
	has_many :coffee_shop_payment_methods, dependent: :destroy
	has_many :payment_methods, :through => :coffee_shop_payment_methods
	
	has_many :coffee_shop_chair_types, dependent: :destroy
	has_many :chair_types, :through => :coffee_shop_chair_types
	
	has_many :coffee_shop_use_scenes, dependent: :destroy
	has_many :use_scenes, :through => :coffee_shop_use_scenes
	
	has_many :coffee_shop_atmosphere_of_clerks, dependent: :destroy
	has_many :atmosphere_of_clerks, :through => :coffee_shop_atmosphere_of_clerks
	
	has_many :coffee_shop_size_of_desks, dependent: :destroy
	has_many :size_of_desks, :through => :coffee_shop_size_of_desks
	
	has_many :coffee_shop_point_cards, dependent: :destroy
	has_many :point_cards, :through => :coffee_shop_point_cards
	
	has_many :coffee_shop_drink_menus, dependent: :destroy
	has_many :drink_menus, :through => :coffee_shop_drink_menus
	
	accepts_nested_attributes_for :coffee_shop_search_categories, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_shop_atmospheres, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_coffee_beans, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_volume_in_shops, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_food_menus, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_shop_bgms, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_shop_sceneries, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_payment_methods, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_chair_types, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_use_scenes, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_atmosphere_of_clerks, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_size_of_desks, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_point_cards, allow_destroy: true
	accepts_nested_attributes_for :coffee_shop_drink_menus, allow_destroy: true
	acts_as_likeable
	has_many_attached :images
	
	# バリデーション
	# 必ず登録してほしい項目
	validates :name, :address, :municipalitie_id, :regular_holiday, presence: true
	
	# 電話番号チェック
	# 非公開にチェックが入っていなければ、重複と桁数をチェックする
	with_options unless: :tell_secret do
		validates :shop_tell, uniqueness: true
		validates :shop_tell, presence: true, format: { with: /\A\d{10,11}\z/ }
	end
	
	# 文字数(最大)
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
	
	# 予算
	validate :shop_badget_lower_and_shop_badget_upper_must_be_set
	
	# enum
	enum outlet: { none_seat: 0, all_seat: 1, part_seat: 2 }, _prefix: true
	enum wifi: { available: 0, not_available: 1 }, _prefix: true
	enum smoking: { smoking: 0, no_smoking: 1, separate_smoke: 2}, _prefix: true
	enum reservation: { reservation_possible: 0, reservations_not_accepted: 1}, _prefix: true
	enum take_out: { available: 0, not_available: 1 }, _prefix: true
	enum with_children: { available: 0, not_available: 1 }, _prefix: true
	enum have_insta_account: { have_account: 0, not_have_account: 1 }, _prefix: true
	enum amusement: { exist: 0, not_exist: 1 }, _prefix: true
	enum look_by_instagram: { exterior: 0, interior: 1, food: 2 }, _prefix: true
	
	scope :search_for_name_and_tell, -> (keyword) {
		where("name LIKE ?", "%#{keyword}%").
		or(where(shop_tell: keyword.to_i))
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
	
	def shop_badget_lower_and_shop_badget_upper_must_be_set
		return if shop_badget_lower.nil? && shop_badget_upper.nil?
		
		if shop_badget_lower.nil?
			errors.add(:shop_badget_lower, "は予算(上限)とペアで入力してください。")
		elsif	shop_badget_upper.nil?
			errors.add(:shop_badget_upper, "は予算(下限)とペアで入力してください。")
		end
	end
	
end