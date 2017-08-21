class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items if current_order.is_a? Order
    @order_items = current_order.guest_order_items if current_order.is_a? GuestOrder
  end
end
