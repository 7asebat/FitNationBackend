class Recipe < ApplicationRecord
  has_one_attached :image

  belongs_to :nutritionist
  
  has_many :nutrition_specifications, dependent: :destroy
  
  has_many :foods_recipes, dependent: :destroy
  has_and_belongs_to_many :foods, through: :food_recipe
end
