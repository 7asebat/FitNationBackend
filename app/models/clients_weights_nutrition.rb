class ClientsWeightsNutrition < ApplicationRecord
  belongs_to :client
  has_and_belongs_to_many :nutrition_specifications
end
