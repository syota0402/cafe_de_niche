class User < ApplicationRecord
  extend SwitchFlg
  has_many :reviews
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  acts_as_liker
  acts_as_followable
  acts_as_follower
         
  # バリデーション
  #文字数
  validates :name, length: { maximum: 15}
  validates :email, length: { maximum: 256}
  validates :age, length: { maximum: 10}
  validates :gender, length: { maximum: 10}
  validates :self_introduction, length: { maximum: 100}
  validates :instagram_url, length: { maximum: 50}
  
  # 空白禁止
  validates :name, presence: true
  
  # 重複禁止
	validates :name, uniqueness: true
	validates :email, uniqueness: true
         
  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    
    result = update(params, *options)
    clean_up_passwords
    result
  end
  
  scope :search_information, -> (keyword) {
    where("name LIKE :keyword OR email LIKE :keyword", keyword: "%#{keyword}%")
  }
end
