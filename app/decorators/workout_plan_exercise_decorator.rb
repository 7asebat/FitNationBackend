class WorkoutPlanExerciseDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      created_at: created_at,
      day: day,
      duration: duration,
      sets: sets,
      reps: reps,
      order: order,
      exercise: exercise
    }
  end
end