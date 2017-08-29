class PaymentCardsController < ApplicationController
  def create
    @payment_card = PaymentCard.create(payment_card_params)

    if @payment_card.id
      render js: "window.location = '#{checkout_confirms_path}'"
    else
      @order = current_order
      respond_to do |format|
        format.js {render '../views/checkout_payments/update.js.erb'}
      end
    end
  end

  def update
    @payment_card = PaymentCard.find(params[:id])
    updated = @payment_card.update_attributes(payment_card_params)

    if updated
      render js: "window.location = '#{checkout_confirms_path}'"
    else
      @order = current_order
      respond_to do |format|
        format.js {render '../views/checkout_payments/update.js.erb'}
      end
    end
  end


  def payment_card_params
    params.require(:payment_card).permit(:card_number, :name, :expiry_date, :cvv, :order_id)
  end
end
