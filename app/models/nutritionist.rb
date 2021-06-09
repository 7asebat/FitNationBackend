class Nutritionist < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }


  has_one_attached :avatar
  belongs_to :user_auth

  has_many :recipes
end
