module OrderItemsHelper
  def order_items_size(order)
    items = order.order_items if order.is_a? Order
    items = order.guest_order_items if order.is_a? GuestOrder
    return items.size if items
    0
  end

  def get_url(order_item, type)
    order_item.is_a?(OrderItem) ? "/order_items/#{type}/#{order_item.id}" : "/guest_order_items/#{type}/#{order_item.id}"
  end
end
