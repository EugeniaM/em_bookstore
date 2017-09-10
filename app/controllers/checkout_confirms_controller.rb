class CheckoutConfirmsController < ApplicationController
  def index
    @order = current_order
    @order_items = @order.order_items
    @order_address = @order.order_address
    @payment_card = @order.payment_card
    shipping_c = ISO3166::Country.new(@order_address.shipping_country)
    @shipping_country = shipping_c.name
    billing_c = ISO3166::Country.new(@order_address.billing_country)
    @billing_country = billing_c.name
  end

  def edit_address
    session[:return_to] = "/checkout_confirms"
    redirect_to checkout_addresses_path
  end

  def edit_delivery
    session[:return_to] = "/checkout_confirms"
    redirect_to checkout_deliveries_path
  end

  def edit_payment
    redirect_to checkout_payments_path
  end
end
