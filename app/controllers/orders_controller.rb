class OrdersController < ApplicationController
  def update
    input = params[:order][:discount].to_s
    coupon_code = current_order.user.coupon_code.to_s

    if input == coupon_code
      @order = current_order
      @order.discount = 5
      @order_items = @order.order_items
      @order.total = @order.subtotal * (1 - @order.discount / 100)
      @order.update(discount: @order.discount, total: @order.total)
      @order.user.update(coupon_used: true)
    end

    respond_to do |format|
      format.js {render '../views/order_items/update.js.erb'}
      format.html
    end
  end
end
