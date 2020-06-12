class Recipe < ApplicationRecord
  acts_as_taggable

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :materials, foreign_key: "recipe_id", dependent: :destroy
  accepts_nested_attributes_for :materials, allow_destroy: true
  has_many :steps, foreign_key: "recipe_id", dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  def self.search(search)
    if search
      Recipe.joins(:materials).where('recipes.title LIKE (?) OR materials.name LIKE (?)', "%#{search}%", "%#{search}%")
    else
      Recipe.all
    end
  end
end

