class UserAuth < ApplicationRecord
  has_secure_password
  has_one :admin, dependent: :destroy
  has_one :client, dependent: :destroy
  has_one :trainer, dependent: :destroy
  has_one :nutritionist, dependent: :destroy
  
  # Enums
  enum role: {client: 0, admin: 1, trainer: 2, nutritionist: 3}


  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 

  def fetch_user
    case UserAuth.roles[self.role]
    when UserAuth.roles[:client]
      return self.client
    when UserAuth.roles[:admin]
      return self.admin
    when UserAuth.roles[:trainer]
      return self.trainer
    when UserAuth.roles[:nutritionist]
      return self.nutritionist
    end
  end
end
