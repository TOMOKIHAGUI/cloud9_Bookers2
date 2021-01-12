class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
	  favorites.where(user_id: user.id).exists?
	end

  def self.search(word, how_search)
    if how_search == "1"
      Book.where(['title LIKE ?', "%#{word}%"])
    elsif how_search == "2"
      Book.where(['title LIKE ?', "#{word}"])
    elsif how_search == "3"
      Book.where(['title LIKE ?', "#{word}%"])
    elsif how_search == "4"
      Book.where(['title LIKE ?', "%#{word}"])
    else
      Book.all
    end
  end

end