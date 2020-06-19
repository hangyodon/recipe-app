class Material < ApplicationRecord
  belongs_to :recipe, optional: true

  validates :name, presence: true
  validates :amount, presence: true

end
