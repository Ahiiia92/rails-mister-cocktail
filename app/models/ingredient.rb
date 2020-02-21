class Ingredient < ApplicationRecord
  has_one_attached :photo
  has_many :doses
  has_many :cocktails, through: :dose

  validates :name, presence: true, uniqueness: true
end
