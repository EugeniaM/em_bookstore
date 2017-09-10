class OrdersController < ApplicationController
  def index
    if !params[:status]
      @orders = Order.where(user_id: current_user.id).order('updated_at DESC')
    else
      @orders = Order.where(user_id: current_user.id, order_status_id: params[:status]).order('updated_at DESC')
    end
    @statuses = OrderStatus.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order_address = @order.order_address
    @payment_card = @order.payment_card
    if @order_address
      shipping_c = ISO3166::Country.new(@order_address.shipping_country)
      @shipping_country = shipping_c.name
      billing_c = ISO3166::Country.new(@order_address.billing_country)
      @billing_country = billing_c.name
    end
  end

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

  def place_order
    @order = current_order
    order_number = "R00000000"[0...-(@order.id.to_s.size)] + @order.id.to_s
    updated = @order.update(order_status_id: 2, number: order_number)
    order_items = @order.order_items
    order_items.each do |oi|
      existing_review = Review.find_by user_id: @order.user_id, book_id: oi.book_id
      book = Book.find(oi.book_id)
      order_counter = book[:order_counter] || 0
      order_counter += 1
      book.update(order_counter: order_counter)
      if existing_review
        existing_review.update(verified: true)
      end
    end
    if updated
      redirect_to "/checkout_completes/#{@order.id}"
    end
  end
end
