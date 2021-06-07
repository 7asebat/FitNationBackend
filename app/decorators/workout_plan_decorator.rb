class WorkoutPlanDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      created_at: created_at,
      updated_at: updated_at,
      client: object&.client&.decorate.as_json,
      trainer: object&.trainer&.decorate.as_json,
      name: name,
      level: level,
      requires_equipment: requires_equipment,
      exercises_count: object&.workout_plan_exercises.count
    }
  end

  def as_json_detailed
    {
      id: id,
      created_at: created_at,
      updated_at: updated_at,
      client: object&.client&.decorate.as_json,
      trainer: object&.trainer&.decorate.as_json,
      name: name,
      level: level,
      requires_equipment: requires_equipment,
      exercise_instances: object&.workout_plan_exercises.decorate.as_json.group_by{ |u| u[:day] }
    }
  end
  def as_json_detailed_no_client
    {
      id: id,
      created_at: created_at,
      updated_at: updated_at,
      name: name,
      level: level,
      requires_equipment: requires_equipment,
      exercise_instances: object&.workout_plan_exercises.decorate.as_json.group_by{ |u| u[:day] }
    }
  end
end