class Food < ApplicationRecord
  has_many :nutrition_specifications
  has_and_belongs_to_many :recipes
end
