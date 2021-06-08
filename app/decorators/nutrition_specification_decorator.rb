class NutritionSpecificationDecorator < Draper::Decorator
    delegate_all

    def as_json
        {
            id:id,
            food:object.food&.decorate.as_json,
            recipe:object.recipe&.decorate.as_json,
            quantity:quantity
        }
    end
end
