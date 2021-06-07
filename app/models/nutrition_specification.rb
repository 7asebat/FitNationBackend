class NutritionSpecification < ApplicationRecord
  belongs_to :food ,optional: true
  belongs_to :recipe, optional: true
  has_and_belongs_to_many :clients_weights_nutritions
end
