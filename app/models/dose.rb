class Dose < ApplicationRecord
  has_one_attached :photo
  belongs_to :cocktail
  belongs_to :ingredient

  validates :description, presence: true
  validates :cocktail, presence: true, uniqueness: { scope: :ingredient }
  validates :ingredient, presence: true

 ## A dose must have a description, a cocktail and an ingredient, and [cocktail, ingredient] pairings should be unique.
end
