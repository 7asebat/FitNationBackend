class ExerciseDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      name: name,
      tips: tips,
      exercise_type: exercise_type,
      meta_data: meta_data,
    }
  end
end