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
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :title, presence: true
  validates :image, presence: true
  validates :calorie, presence: true
  validates :sugar, presence: true
  validates :category, presence: true


end

