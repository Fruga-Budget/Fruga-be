class User < ApplicationRecord
  has_many :advices, dependent: :destroy
  has_secure_password

  validates :user_name, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 10 }, confirmation: true
  validates :password_confirmation, presence: true
end