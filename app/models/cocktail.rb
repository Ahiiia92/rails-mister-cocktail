class Cocktail < ApplicationRecord
  has_many :ingredients, through :dose
end
