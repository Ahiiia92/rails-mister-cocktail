class Ingredient < ApplicationRecord
  has_many :cocktails, through :dose
end
