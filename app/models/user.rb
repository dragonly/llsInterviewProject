class User < ApplicationRecord
  before_save { username.downcase! }
  validates :username, presence: true, length: { maximum: 64 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  has_one :balance, dependent: :destroy
  has_many :red_packets, dependent: :destroy
  has_many :red_packet_records, dependent: :destroy

  # for test fixture password generation
  def User.password_digest(string)
    cost = BCrypt::Engine::MIN_COST
    BCrypt::Password.create(string, cost: cost)
  end
end
