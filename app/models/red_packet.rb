class RedPacket < ApplicationRecord
  belongs_to :user
  has_many :red_packet_records
  validates :amount, presence: true
  validates :quantity, presence: true
  validate :amount_quantity_validation

  def amount_quantity_validation
    if amount < 1
      errors.add(:amount, "amount must be positive")
    end
    if quantity < 1
      errors.add(:quantity, "quantity must be positive")
    end
    if amount < quantity
      errors.add("amount must not be less than quantity")
    end
  end
end
