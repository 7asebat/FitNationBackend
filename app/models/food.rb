class Food < ApplicationRecord
  has_one_attached :image
  has_many :nutrition_specifications
  has_and_belongs_to_many :recipes
end
