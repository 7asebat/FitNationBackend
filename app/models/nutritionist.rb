class Nutritionist < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user_auth

  has_many :recipes
end
