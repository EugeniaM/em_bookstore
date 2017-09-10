module OrdersHelper
  def format_all_order_date(date)
    date.strftime("%F")
  end

  def get_order_number(order)
    order.number || "R00000000"[0...-(order.id.to_s.size)] + order.id.to_s
  end

  def selected_sort_status
    if params[:status]
      OrderStatus.find(params[:status]).display_title
    else
      "All"
    end
  end

  def get_redirect_link(order)
    if order.order_status_id == 1
      cart_path
    else
      "/order/#{order.id}"
    end
  end
end
