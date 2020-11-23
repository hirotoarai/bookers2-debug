class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  include JpPrefecture
  jp_prefecture :prefecture_code

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :followed_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followeds, through: :followed_relationships
  has_many :follower_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  
  
  def followed?(other_user)
    self.followeds.include?(other_user)
  end
  
  def follow(other_user)
    self.followed_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.followed_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def self.search(search, type)
      if search
      	if type == "exact"
          User.where('name LIKE ?', "#{search}")
        elsif type == "forward"
          User.where('name LIKE ?', "#{search}%")
        elsif type == "backward"
          User.where('name LIKE ?', "%#{search}")
        elsif type == "partial"
          User.where('name LIKE ?', "%#{search}%")
        end
      else
        User.all
      end
  end
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  attachment :profile_image, destroy: false
  validates :introduction, length: { maximum: 50 }
  validates :name, uniqueness: true,length: { maximum: 20, minimum: 2 }
end
