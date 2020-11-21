class Book < ApplicationRecord
	belongs_to :user

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	
	def favorited_by?(user)
	  favorites.where(user_id: user.id).exists?
	end
	
	def self.search(search, type)
      if search
      	if type == "exact"
          Book.where('title LIKE ?', "#{search}")
        elsif type == "forward"
          Book.where('title LIKE ?', "#{search}%")
        elsif type == "backward"
          Book.where('title LIKE ?', "%#{search}")
        elsif type == "partial"
          Book.where('title LIKE ?', "%#{search}%")
        end
      else
        Book.all
      end
	end
end
