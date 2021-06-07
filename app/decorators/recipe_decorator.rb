class RecipeDecorator < Draper::Decorator
    delegate_all
  
    def as_json
      {
        id: id,
        name: name,
        description: description,
        image: image.url,
        foods: foods.decorate.as_json,
        nutritionist_id: nutritionist_id
      }
    end
  end