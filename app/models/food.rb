class Food < ApplicationRecord
  has_one_attached :image
  has_many :nutrition_specifications, dependent: :destroy
  
  has_and_belongs_to_many :recipes, through: :foods_recipes
  has_many :foods_recipes, dependent: :destroy


  enum food_types: {
    Vegetables: 0,
    Fruits: 1,
    Seafood: 2
  }
end
