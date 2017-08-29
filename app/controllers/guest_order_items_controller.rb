class GuestOrderItemsController < ApplicationController
  def create
    @guest_order = current_order
    @guest_order.session_id = session.id
    repeat_books = @guest_order.guest_order_items.select { |item| item[:book_id].to_s == params[:guest_order_item][:book_id].to_s}
    if repeat_books.size == 0
      @guest_order_item = @guest_order.guest_order_items.new(guest_order_item_params)
      @guest_order.save
    else
      @guest_order_item = repeat_books[0]
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @guest_order = current_order
    @guest_order_item = @guest_order.guest_order_items.find(params[:id])
    @order_item.update_attributes(guest_order_item_params)
    @order_items = @guest_order.guest_order_items

    respond_to do |format|
      format.js
      format.html
    end
  end

  def decrement
    @order = current_order
    @order_item = @order.guest_order_items.find(params[:id])
    @order_item.quantity = @order_item.quantity == 1 ? 1 : @order_item.quantity - 1
    @order_item.update({quantity: @order_item.quantity})
    @order_items = @order.guest_order_items
    @order.subtotal = @order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
    @order.update(subtotal: @order[:subtotal])

    respond_to do |format|
      format.js {render '../views/guest_order_items/update.js.erb'}
      format.html
    end
  end

  def increment
    @order = current_order
    @order_item = @order.guest_order_items.find(params[:id])
    @order_item.quantity += 1
    @order_item.update({quantity: @order_item.quantity})
    @order_items = @order.guest_order_items
    @order.subtotal = @order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
    @order.update(subtotal: @order[:subtotal])

    respond_to do |format|
      format.js {render '../views/guest_order_items/update.js.erb'}
      format.html
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.guest_order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.guest_order_items

    respond_to do |format|
      format.js
      format.html
    end
  end

  def guest_order_item_params
    params.require(:guest_order_item).permit(:quantity, :book_id)
  end
end
