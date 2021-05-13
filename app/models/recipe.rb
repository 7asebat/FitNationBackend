class Recipe < ApplicationRecord
  belongs_to :nutritionist
  
  has_many :nutrition_specifications
  has_and_belongs_to_many :foods
end
