class Order < ApplicationRecord
  belongs_to :order_status
  belongs_to :user
  has_many :order_items
  before_validation :set_order_status, on: :create
  before_save :update_subtotal
  before_save :update_total
  has_one :order_address
  accepts_nested_attributes_for :order_address, allow_destroy: true
  has_one :payment_card
  accepts_nested_attributes_for :payment_card, allow_destroy: true

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def total
    subtotal.to_f * ( 1 - discount.to_f / 100 ) + (delivery.to_f)
  end

  private
  
  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def update_total
    self[:total] = total
  end
end
