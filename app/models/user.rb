class User < ApplicationRecord
  before_save { username.downcase! }
  validates :username, presence: true, length: { maximum: 64 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
end
