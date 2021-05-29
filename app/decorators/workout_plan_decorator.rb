class WorkoutPlanDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      created_at: created_at,
      updated_at: updated_at,
      client: object&.client&.decorate.as_json,
      trainer: object&.trainer&.decorate.as_json
    }
  end
end