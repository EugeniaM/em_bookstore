class BillingAddressesController < ApplicationController
  def create
    BillingAddress.create(billing_address_params)
  end

  def update
    @billing_address = BillingAddress.find(params[:id])
    @billing_address.update_attributes(billing_address_params)

    @selected_bill = @billing_address[:country]
    @phone_code_bill = @billing_address[:phone]

    respond_to do |format|
      format.js {render '../views/users/update_billing_address.js.erb'}
    end
  end


  def billing_address_params
    params.require(:billing_address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :user_id)
  end
end
