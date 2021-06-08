class TrainerClientMessageDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      body: body,
      created_at: created_at,
      sent_by: sent_by
    }
  end
end