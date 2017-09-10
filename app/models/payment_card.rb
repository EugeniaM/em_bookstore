class PaymentCard < ApplicationRecord
  belongs_to :order

  VALID_CARD_NUMBER_REGEX = /\A[0-9]{16}\z/
  VALID_NAMES_REGEX = /\A[a-zA-Z ]+\z/
  VALID_EXPIRY_REGEX = /\A(0[1-9]|1[0-2])\/([0-9]{2})\z/
  VALID_CVV_REGEX = /\A[0-9]{3,4}\z/
  validates :card_number, :name, :expiry_date, :cvv, presence: true
  validates :card_number, format: { with: VALID_CARD_NUMBER_REGEX }
  validates :name, format: { with: VALID_NAMES_REGEX }
  validates :expiry_date, format: { with: VALID_EXPIRY_REGEX }
  validates :cvv, format: { with: VALID_CVV_REGEX }
end
