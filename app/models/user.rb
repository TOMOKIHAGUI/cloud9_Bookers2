class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロワーとuserの紐づけ
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォローとuserの紐づけ
  has_many :following_users, through: :follower, source: :followed #フォローとフォロワーの紐づけ
  has_many :follower_users, through: :followed, source: :follower  #フォロワーとフォローの紐づけ
  
  #フォロー機能で使用するメソッド定義
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_users.include?(user)
  end
  #ここまで
  
  #検索機能用
  def self.search(word, how_search)
    if how_search == "1"
      User.where(['name LIKE ?', "%#{word}%"])
    elsif how_search == "2"
      User.where(['name LIKE ?', "#{word}"])
    elsif how_search == "3"
      User.where(['name LIKE ?', "#{word}%"])
    elsif how_search == "4"
      User.where(['name LIKE ?', "%#{word}"])
    else
      User.all
    end
  end

  #住所検索用
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  #ここまで

end