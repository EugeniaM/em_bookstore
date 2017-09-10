class CheckoutDeliveriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @order = current_order
    if(@order.delivery == 0)
      total = @order.subtotal.to_f * ( 1 - @order.discount.to_f / 100 ) + 5
      @order.update(delivery: 5.0, total: total)
    end
  end

  def update
    @order = current_order
    delivery = params[:delivery]
    total = @order.subtotal.to_f * ( 1 - @order.discount.to_f / 100 ) + delivery.to_f
    @order.update(delivery: delivery.to_f, total: total)

    respond_to do |format|
      format.js {render '../views/checkout_deliveries/update.js.erb'}
      format.html
    end
  end
end