class Nutritionist < ApplicationRecord
  belongs_to :user_auth

  has_many :recipes
end
