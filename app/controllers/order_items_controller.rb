class OrderItemsController < ApplicationController
  skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  def create
    @order = current_order
    @order.user_id = current_user.id
    repeat_books = @order.order_items.select { |item| item[:book_id].to_s == params[:order_item][:book_id].to_s}
    if repeat_books.size == 0
      @order_item = @order.order_items.new(order_item_params)
      @order.save
    else
      @order_item = repeat_books[0]
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
    @order.subtotal = @order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
    @order.update(subtotal: @order[:subtotal])

    respond_to do |format|
      format.json {render '../views/order_items/update.js.erb'}
      format.html
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items

    respond_to do |format|
      format.js
      format.html
    end
  end

  def decrement
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.quantity = @order_item.quantity == 1 ? 1 : @order_item.quantity - 1
    @order_item.update({quantity: @order_item.quantity})
    @order_items = @order.order_items
    @order.subtotal = @order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
    @order.update(subtotal: @order[:subtotal])

    respond_to do |format|
      format.js {render '../views/order_items/update.js.erb'}
      format.html
    end
  end

  def increment
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.quantity += 1
    @order_item.update({quantity: @order_item.quantity})
    @order_items = @order.order_items
    @order.subtotal = @order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
    @order.update(subtotal: @order[:subtotal])

    respond_to do |format|
      format.js {render '../views/order_items/update.js.erb'}
      format.html
    end
  end

  private
  
  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end



