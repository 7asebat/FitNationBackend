class ClientsWeightsNutritionDecorator < Draper::Decorator
    delegate_all
    def as_json
      {
        id: id,
        client_id: client_id,
        date: date,
        weight: weight,
        nutrition_specifications: object.nutrition_specifications.decorate.as_json
      }
    end
  end