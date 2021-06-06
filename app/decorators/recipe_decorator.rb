class RecipeDecorator < Draper::Decorator
    delegate_all
  
    def as_json
      {
        id: id,
        name: name,
        description: description,
        photo: photo,
        foods: foods,
        nutritionist_id: nutritionist_id
      }
    end
  end