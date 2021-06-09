class ClientsExerciseInstanceDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      client: client,
      date: date,
      performance: performance,
      sets: sets,
      reps: reps,
      duration: duration,
      created_at: created_at,
      exercise: exercise&.present? ? exercise&.decorate&.as_json : workout_plan_exercise&.exercise&.decorate&.as_json
    }
  end
end