class CheckoutCompletesController < ApplicationController
  def index
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @user = @order.user
    @order_address = @order.order_address
    billing_c = ISO3166::Country.new(@order_address.billing_country)
    @billing_country = billing_c.name
  end
end
