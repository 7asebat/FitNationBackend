class Admin < ApplicationRecord
  has_one_attached :avatar

  belongs_to :user_auth, dependent: :destroy
end
