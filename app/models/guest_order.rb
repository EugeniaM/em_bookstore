class GuestOrder < ApplicationRecord
  belongs_to :order_status
  has_many :guest_order_items
  before_validation :set_order_status, on: :create
  before_save :update_subtotal

  def subtotal
    guest_order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def total
    subtotal.to_f * ( 1 - discount.to_f / 100 )
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
