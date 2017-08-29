module CheckoutHelper
  def initial_billing_value(param)
    return @order_address["billing_#{param}".to_sym] if @order_address && @order_address["billing_#{param}".to_sym]
    return @user_billing_address[param] if @user_billing_address && @user_billing_address[param]
    ""
  end

  def initial_shipping_value(param)
    return @order_address["shipping_#{param}".to_sym] if @order_address && @order_address["shipping_#{param}".to_sym]
    return @user_shipping_address[param] if @user_shipping_address && @user_shipping_address[param]
    ""
  end

  def order_address_url
    if @order_address.id
      "/order_addresses/update/#{@order_address.id}"
    else
      "/order_addresses/create"
    end
  end

  def order_payment_url
    if @payment_card.id
      "/payment_cards/update/#{@payment_card.id}"
    else
      "/payment_cards/create"
    end
  end

  def method_define(object)
    if object.id
      :patch
    else
      :post
    end
  end

  def address_checked
    !@order.order_address.nil?
  end

  def payment_checked
    !@order.payment_card.nil?
  end

  def default_delivery_checked(cost)
    @order.delivery == 0 || @order.delivery == cost.to_f
  end

  def delivery_checked(cost)
    @order.delivery == cost.to_f
  end

  def billing_full_name(address)
    "#{address.billing_first_name} #{address.billing_last_name}"
  end

  def shipping_full_name(address)
    "#{address.shipping_first_name} #{address.shipping_last_name}"
  end

  def delivery_title(id)
    titles = { "5": "Delivery Next Day!", "10": "Pick Up In-Store", "15": "Expressit" }
    titles[id.to_i.to_s.to_sym]
  end

  def get_last_digits
    "** ** ** #{@payment_card.card_number[-4, 4]}"
  end

  def redirect_from_delivery
    redirect_path = session[:return_to] == "/checkout_confirms" ? checkout_confirms_path : checkout_payments_path
    session[:return_to] = nil
    redirect_path
  end

  def format_order_date(date)
    date.strftime("%B %d, %Y")
  end
end