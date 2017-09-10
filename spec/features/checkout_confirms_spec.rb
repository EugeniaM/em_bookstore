require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Checkout_confirms" do
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
    visit checkout_addresses_path
    order_id = find("#order_address_order_id", visible: false).value
    order_address = FactoryGirl.create(:order_address, order_id: order_id)
    payment_card = FactoryGirl.create(:payment_card, order_id: order_id)
    visit checkout_confirms_path
  end

  it { should have_selector('h3.general-subtitle', text: 'Shipping Address') }
  it { should have_selector('h3.general-subtitle', text: 'Billing Address') }
  it { should have_selector('h3.general-subtitle', text: 'Shipments') }
  it { should have_selector('h3.general-subtitle', text: 'Payment Information') }

  describe "when user clicks edit shipping address" do
    it "should redirect to checkout addresses page" do
      first(:link, 'edit', href: "/checkout_confirms/edit_address").click
      expect(page).to have_selector(".billing-address-container-checkout")
      expect(page).to have_selector(".shipping-address-container-checkout")
    end
  end

  describe "when user clicks edit Shipments" do
    it "should redirect to checkout checkout shipments" do
      click_link('edit', href: "/checkout_confirms/edit_delivery")
      expect(page).to have_selector("h3.general-subtitle", text: "Shipping Method")
    end
  end

  describe "when user clicks edit Payment Information" do
    it "should redirect to checkout checkout payments" do
      click_link('edit', href: "/checkout_confirms/edit_payment")
      expect(page).to have_selector("h3.general-subtitle", text: "Credit Card")
    end
  end

  # describe "when user places order" do
  #   it "should change order status" do
  #     visit checkout_addresses_path
  #     order_id = find("#order_address_order_id", visible: false).value
  #     visit checkout_confirms_path
  #     puts "!!!!!!!!!!!!!!"
  #     puts order_id
  #     puts "!!!!!!!!!!!!!!"
  #     click_link('Place Order')
  #     expect(Order.find(order_id)[:order_status_id]).to eq 2
  #   end
  # end
end
