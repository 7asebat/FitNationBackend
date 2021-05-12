class UserAuth < ApplicationRecord
  has_secure_password
  has_many :admins
  has_many :clients
  has_many :trainers
  has_many :nutritionists
  
  # Enums
  enum role: [:user, :admin, :trainer, :nutritionist]

  # Validations
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
