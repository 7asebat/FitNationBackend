class FoodDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      has_image: image.attached?,
      image: image.service_url,
      name: name,
      nutrition_facts: nutrition_facts,
      food_type: food_type,
    }
  end
end