class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_recipes, through: :favorites, source: :recipe
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :nickname, presence: true
  
  def already_favorited?(recipe)
    self.favorites.exists?(recipe_id: recipe.id)
  end

  def self.guest
    find_or_create_by!(nickname: 'sample', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
