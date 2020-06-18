class Report < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :text, presence: true
  validates :image, presence: true
end
