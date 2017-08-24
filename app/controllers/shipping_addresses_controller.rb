class ShippingAddressesController < ApplicationController
  def create
    ShippingAddress.create(shipping_address_params)
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.update_attributes(shipping_address_params)

    @selected_ship = @shipping_address[:country]
    @phone_code_ship = @shipping_address[:phone]

    respond_to do |format|
      format.js {render '../views/users/update_shipping_address.js.erb'}
    end
  end


  def shipping_address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :user_id)
  end
end
