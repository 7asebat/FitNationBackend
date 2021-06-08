class AdminDecorator < Draper::Decorator
  delegate_all
  def as_json
    {
      id: id,
      name: name,
      email: user_auth&.email,
      role: user_auth&.role,
      avatar: avatar.url
    }
  end
end