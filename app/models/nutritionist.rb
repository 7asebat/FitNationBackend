class Nutritionist < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user_auth, dependent: :destroy

  has_many :recipes
end
