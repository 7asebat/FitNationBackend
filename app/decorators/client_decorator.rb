class ClientDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      name: name,
      country: country,
      email: user_auth&.email,
      role: user_auth&.role,
      avatar: avatar.url,
      active_workout_plan: workout_plans_id
    }
  end
end