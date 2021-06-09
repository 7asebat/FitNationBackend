class RecipeDecorator < Draper::Decorator
    delegate_all
  
    def as_json
      {
        id: id,
        name: name,
        description: description,
        image: image.url,
        foods: foods_recipes.map do |u|
          {
            quantity: u[:quantity],
            food: u&.food&.decorate&.as_json
          }
        end,
        nutritionist_id: nutritionist_id
      }
    end
  end