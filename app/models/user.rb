class User < ApplicationRecord
  has_many :messages
  has_many :conversations, through: :messages

  has_secure_password

  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
