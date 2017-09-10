require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Checkout_payments" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let(:last_added_books) { FactoryGirl.create_list(:book, 3, price: 20) }
  before(:each) do
    visit new_user_session_path
    fill_in I18n.t('auth.email_label'), with: user.email
    fill_in I18n.t('auth.psw_label'), with: user.password
    click_button(I18n.t('auth.log_in'))
    visit root_path
    @last_added_books = last_added_books
    first('.carousel-buy-link').click
    visit checkout_payments_path
  end

  it { should have_selector('h3.general-subtitle', text: 'Credit Card') }

  describe "when user saves invalid data", js: true do
    it "should not save payment_card" do
      order_id = find("#payment_card_order_id", visible: false).value
      click_button("Save and Continue")
      expect(PaymentCard.find_by(order_id: order_id)).to be_nil
      expect(page).to have_selector('h3.general-subtitle', text: 'Credit Card')
    end
  end

  # describe "when user saves valid data", js: true do
  #   it "should not save payment_card" do
  #     order_id = find("#payment_card_order_id", visible: false).value
  #     order = Order.find(order_id)
  #     order_address = FactoryGirl.create(:order_address, order_id: order_id)
  #     fill_in "Card Number", with: "1111111111111111"
  #     fill_in "Name on Card", with: "Test"
  #     fill_in "MM / YY", with: "12/25"
  #     fill_in "CVV", with: "111"
  #     click_button("Save and Continue")
  #     expect(page).to have_selector('h3.general-subtitle', text: 'Shipping Address')
  #     expect(page).to have_selector('h3.general-subtitle', text: 'Billing Address')
  #     expect(page).to have_selector('h3.general-subtitle', text: 'Shipments')
  #     expect(page).to have_selector('h3.general-subtitle', text: 'Payment Information')
  #   end
  # end
end
