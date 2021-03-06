class GuestOrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :guest_order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :book_present
  validate :guest_order_present

  before_save :complete

  def unit_price
    if persisted?
      self[:unit_price]
    else
      book.price
    end
  end

  def total_price
    unit_price * quantity
  end

private
  def book_present
    if book.nil?
      errors.add(:book, "is not a valid book.")
    end
  end

  def guest_order_present
    if guest_order.nil?
      errors.add(:guest_order, "is not a valid order.")
    end
  end

  def complete
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
