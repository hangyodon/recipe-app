class Step < ApplicationRecord
  belongs_to :recipe, optional: true

  validates :number, presence: true
  validates :process, presence: true

end
