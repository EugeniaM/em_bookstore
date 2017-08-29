class OrderAddress < ApplicationRecord
  belongs_to :order

  VALID_NAMES_REGEX = /\A[a-zA-Z .-]+\z/
  VALID_ADDRESS_REGEX = /\A[a-zA-Z0-9 ,.-]+\z/
  VALID_ZIP_REGEX = /\A[0-9-]+\z/
  VALID_PHONE_REGEX = /\A\+[0-9]+\z/
  validates :billing_first_name, 
            :billing_last_name, 
            :billing_address, 
            :billing_city, 
            :billing_zip, 
            :billing_country, 
            :billing_phone, 
            :shipping_first_name, 
            :shipping_last_name, 
            :shipping_address, 
            :shipping_city, 
            :shipping_zip, 
            :shipping_country, 
            :shipping_phone, 
            presence: true
  validates :billing_first_name, 
            :billing_last_name, 
            :billing_country, 
            :billing_city,
            :shipping_first_name, 
            :shipping_last_name, 
            :shipping_country, 
            :shipping_city, 
            format: { with: VALID_NAMES_REGEX }, length: { maximum: 50 }
  validates :billing_address, :shipping_address, format: { with: VALID_ADDRESS_REGEX }, length: { maximum: 50 }
  validates :billing_zip, :shipping_zip, format: { with: VALID_ZIP_REGEX }, length: { maximum: 10 }
  validates :billing_phone, :shipping_phone, format: { with: VALID_PHONE_REGEX }, length: { maximum: 15 }
end
