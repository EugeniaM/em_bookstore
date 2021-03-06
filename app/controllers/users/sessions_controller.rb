class Users::SessionsController < Devise::SessionsController
  # layout 'login'
  skip_before_action :require_no_authentication
  before_action :resource_name
  before_action :save_orders, only: [:create]

  def resource_name
    :user
  end

  private

  def save_orders
    guest_order = GuestOrder.find_by session_id: session.id
    return if !guest_order
    
    guest_order_items = guest_order.guest_order_items

    user = User.find_by email: params[:user][:email]
    return if !user

    user_order = Order.find_by user_id: user.id, order_status_id: 1

    if !user_order
      new_order = Order.new
      new_order.order_status_id = guest_order.order_status_id
      new_order.total = guest_order.total
      new_order.subtotal = guest_order.subtotal
      new_order.user_id = user.id
      new_order.created_at = guest_order.created_at
      new_order.updated_at = guest_order.updated_at
      new_order.discount = guest_order.discount
      new_order.save

      guest_order_items.each do |oi|
        new_oi = OrderItem.new
        new_oi.book_id = oi.book_id
        new_oi.order_id = new_order.id
        new_oi.unit_price = oi.unit_price
        new_oi.total_price = oi.total_price
        new_oi.quantity = oi.quantity
        new_oi.created_at = oi.created_at
        new_oi.updated_at = oi.updated_at
        new_oi.save
        GuestOrderItem.destroy(oi.id)
      end

      GuestOrder.destroy(guest_order.id)
    else
      guest_order_items.each do |oi|
        existing_oi = OrderItem.find_by order_id: user_order.id, book_id: oi.book_id
        if !existing_oi
          new_oi = OrderItem.new
          new_oi.book_id = oi.book_id
          new_oi.order_id = user_order.id
          new_oi.unit_price = oi.unit_price
          new_oi.total_price = oi.total_price
          new_oi.quantity = oi.quantity
          new_oi.created_at = oi.created_at
          new_oi.updated_at = oi.updated_at
          new_oi.save
          GuestOrderItem.destroy(oi.id)
        else
          GuestOrderItem.destroy(oi.id)
        end
      end
    end
  end

end