class CheckoutAddressesController < ApplicationController
  def index
    @order = current_order
    @order_address = current_order.order_address || OrderAddress.new
    @user_billing_address = current_user.billing_address
    @user_shipping_address = current_user.shipping_address

    @selected_bill = @order_address[:billing_country] || 
                     (@user_billing_address ? @user_billing_address[:country] : "UA")
    @phone_code_bill = @order_address[:billing_phone] || 
                       (@user_billing_address ? @user_billing_address[:phone] : "+380")
    @selected_ship = @order_address[:shipping_country] || 
                     (@user_shipping_address ? @user_shipping_address[:country] : "UA")
    @phone_code_ship = @order_address[:shipping_phone] || 
                       (@user_shipping_address ? @user_shipping_address[:phone] : "+380")
  end

  def billing_country_change
    c = ISO3166::Country.new(params[:country])
    @selected_bill = params[:country]
    @phone_code_bill = "+#{c.country_code}"
    @order = current_order
    @order_address = current_order.order_address || OrderAddress.new
    @user_billing_address = current_user.billing_address
    @user_shipping_address = current_user.shipping_address
    @selected_ship = params["other_country"] || "UA"
    @phone_code_ship = "+#{params[:other_phone].strip}" || "+380"
    respond_to do |format|
      format.js {render '../views/checkout_addresses/update_address.js.erb'}
    end
  end

  def shipping_country_change
    c = ISO3166::Country.new(params[:country])
    @selected_ship = params[:country]
    @phone_code_ship = "+#{c.country_code}"
    @order = current_order
    @order_address = current_order.order_address || OrderAddress.new
    @user_billing_address = current_user.billing_address
    @user_shipping_address = current_user.shipping_address
    @selected_bill = params["other_country"] || "UA"
    @phone_code_bill = "+#{params[:other_phone].strip}" || "+380"
    respond_to do |format|
      format.js {render '../views/checkout_addresses/update_address.js.erb'}
    end
  end
end
