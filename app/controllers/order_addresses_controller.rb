class OrderAddressesController < ApplicationController
  def create
    use_billing = params[:use_billing] == 'on'
    address_data = params[:order_address]
    if use_billing
      @order_address = OrderAddress.create(
        billing_first_name: address_data[:billing_first_name],
        billing_last_name: address_data[:billing_last_name],
        billing_address: address_data[:billing_address], 
        billing_city: address_data[:billing_city], 
        billing_zip: address_data[:billing_zip], 
        billing_country: address_data[:billing_country], 
        billing_phone: address_data[:billing_phone], 
        shipping_first_name: address_data[:billing_first_name], 
        shipping_last_name: address_data[:billing_last_name], 
        shipping_address: address_data[:billing_address], 
        shipping_city: address_data[:billing_city], 
        shipping_zip: address_data[:billing_zip], 
        shipping_country: address_data[:billing_country], 
        shipping_phone: address_data[:billing_phone], 
        order_id: address_data[:order_id]
      )
    else
      @order_address = OrderAddress.create(order_address_params)
    end

    if @order_address.id
      render js: "window.location = '#{checkout_deliveries_path}'"
    else
      @order = current_order
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
      respond_to do |format|
        format.js {render '../views/checkout_addresses/update_address.js.erb'}
        format.html
      end
    end
  end

  def update
    use_billing = params[:use_billing] == 'on'
    address_data = params[:order_address]
    @order_address = OrderAddress.find(params[:id])
    if use_billing
      updated = @order_address.update(
        billing_first_name: address_data[:billing_first_name],
        billing_last_name: address_data[:billing_last_name],
        billing_address: address_data[:billing_address], 
        billing_city: address_data[:billing_city], 
        billing_zip: address_data[:billing_zip], 
        billing_country: address_data[:billing_country], 
        billing_phone: address_data[:billing_phone], 
        shipping_first_name: address_data[:billing_first_name], 
        shipping_last_name: address_data[:billing_last_name], 
        shipping_address: address_data[:billing_address], 
        shipping_city: address_data[:billing_city], 
        shipping_zip: address_data[:billing_zip], 
        shipping_country: address_data[:billing_country], 
        shipping_phone: address_data[:billing_phone], 
        order_id: address_data[:order_id]
      )
    else
      updated = @order_address.update_attributes(order_address_params)
    end

    if updated
      redirect_path = session[:return_to] == "/checkout_confirms" ? checkout_confirms_path : checkout_deliveries_path
      session[:return_to] = nil
      render js: "window.location = '#{redirect_path}'"
    else
      @order = current_order
      @user_billing_address = current_user.billing_address
      @user_shipping_address = current_user.shipping_address
      @selected_bill = @order_address[:billing_country] || 
                       @user_billing_address ? @user_billing_address[:country] : "UA"
      @phone_code_bill = @order_address[:billing_phone] || 
                         @user_billing_address ? @user_billing_address[:phone] : "+380"
      @selected_ship = @order_address[:shipping_country] || 
                       @user_shipping_address ? @user_shipping_address[:country] : "UA"
      @phone_code_ship = @order_address[:shipping_phone] || 
                         @user_shipping_address ? @user_shipping_address[:phone] : "+380"
      respond_to do |format|
        format.js {render '../views/checkout_addresses/update_address.js.erb'}
      end
    end
  end


  def order_address_params
    params.require(:order_address).permit(
      :billing_first_name, 
      :billing_last_name, 
      :billing_address, 
      :billing_city, 
      :billing_zip, 
      :billing_country, 
      :billing_phone, 
      :shipping_first_name, 
      :shipping_last_name, 
      :shipping_address, 
      :shipping_city, 
      :shipping_zip, 
      :shipping_country, 
      :shipping_phone, 
      :order_id)
  end
end
