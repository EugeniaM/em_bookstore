class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    if current_user
      order = Order.find_by user_id: current_user.id, order_status_id: 1
      order = order || Order.new
      order
    else
      order = GuestOrder.find_by session_id: session.id
      order = order || GuestOrder.new
    end
  end
end
