class Nutritionist < ApplicationRecord
  belongs_to :user_auth

  has_many :recipes

  def decorate
    return {
      id: self.id,
      name: self.name,
      country: self.country,
      email: self.user_auth.email,
      role: self.user_auth.role
    }
  end
end
