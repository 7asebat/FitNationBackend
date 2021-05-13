class NutritionSpecification < ApplicationRecord
  belongs_to :food
  belongs_to :recipe
  has_and_belongs_to_many :clients_weights_nutritions
end
