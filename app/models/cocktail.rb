class Cocktail < ApplicationRecord
  has_one_attached :photo
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, presence: true, uniqueness: true
  validates :description_drink, presence: true
  validates :photo, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
