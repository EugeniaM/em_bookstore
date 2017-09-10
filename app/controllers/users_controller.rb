class UsersController < ApplicationController
  def settings
    @user = current_user
    @billing_address = @user.billing_address || BillingAddress.new
    @selected_bill = @billing_address[:country] || "UA"
    @phone_code_bill = @billing_address[:phone] || "+380"
    @shipping_address = @user.shipping_address || ShippingAddress.new
    @selected_ship = @shipping_address[:country] || "UA"
    @phone_code_ship = @shipping_address[:phone] || "+380"
    respond_to do |format|
      format.html { render file: "users/settings.html" }
    end
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)

    respond_to do |format|
      format.js {render '../views/users/update.js.erb'}
      format.html
    end
  end

  def update_password
    @user = current_user
    @user.update_with_password(user_params)

    respond_to do |format|
      format.js {render '../views/users/update.js.erb'}
      format.html
    end
  end

  def destroy
    user_order = Order.find_by user_id: current_user.id, order_status_id: 1
    if !user_order.nil?
      order_items = user_order.order_items
      if order_items.size
        order_items.each do |oi|
          OrderItem.destroy(oi.id)
        end
      end
      Order.destroy(user_order.id)
    end

    billing_address = current_user.billing_address
    if !billing_address.nil?
      BillingAddress.destroy(billing_address.id)
    end

    shipping_address = current_user.shipping_address
    if !shipping_address.nil?
      ShippingAddress.destroy(shipping_address.id)
    end

    if User.destroy(current_user.id)
      redirect_to root_path
    end
  end

  def billing_country_change
    c = ISO3166::Country.new(params[:country])
    @selected_bill = params[:country]
    @phone_code_bill = "+#{c.country_code}"
    @billing_address = current_user.billing_address || BillingAddress.new
    respond_to do |format|
      format.js {render '../views/users/update_billing_address.js.erb'}
    end
  end

  def shipping_country_change
    c = ISO3166::Country.new(params[:country])
    @selected_ship = params[:country]
    @phone_code_ship = "+#{c.country_code}"
    @shipping_address = current_user.shipping_address || ShippingAddress.new
    respond_to do |format|
      format.js {render '../views/users/update_shipping_address.js.erb'}
    end
  end

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end
end
