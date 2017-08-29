class CheckoutPaymentsController < ApplicationController
  def index
    @order = current_order
    @payment_card = current_order.payment_card || PaymentCard.new
  end
end
