class UserAuth < ApplicationRecord
  has_secure_password
  
  # Enums
  enum role: [:user, :admin, :coach, :nutritionist]

  # Validations
  validates: :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
