class ShippingAddress < ApplicationRecord
  belongs_to :user

  VALID_NAMES_REGEX = /\A[a-zA-Z .-]+\z/
  VALID_ADDRESS_REGEX = /\A[a-zA-Z0-9 ,.-]+\z/
  VALID_ZIP_REGEX = /\A[0-9-]+\z/
  VALID_PHONE_REGEX = /\A\+[0-9]+\z/
  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, :country, :city, format: { with: VALID_NAMES_REGEX }, length: { maximum: 50 }
  validates :address, format: { with: VALID_ADDRESS_REGEX }, length: { maximum: 50 }
  validates :zip, format: { with: VALID_ZIP_REGEX }, length: { maximum: 10 }
  validates :phone, format: { with: VALID_PHONE_REGEX }, length: { maximum: 15 }
end
