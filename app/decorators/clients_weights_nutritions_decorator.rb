class ClientsWeightsNutritionsDecorator < Draper::CollectionDecorator
    def as_json
      object.map { |u| u.decorate.as_json }
    end
  end