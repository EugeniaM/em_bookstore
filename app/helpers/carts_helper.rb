module CartsHelper
  def round_price(price)
    price.round(2)
  end

  def count_discount(subtotal, discount)
    "€#{(subtotal * discount / 100).round(2)}"
  end

  def get_cart_url(order)
    order.is_a?(Order) ? "/orders/#{order.id}" : "/guest_orders/#{order.id}"
  end
end
