require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Checkout_address" do
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
  end

  it { should have_selector('h1.general-title-margin', text: 'Checkout') }

  describe "when user has no billing address" do
    it { should have_field('order_address[billing_first_name]', with: "") }
    it { should have_field('order_address[billing_last_name]', with: "") }
    it { should have_field('order_address[billing_address]', with: "") }
    it { should have_field('order_address[billing_city]', with: "") }
    it { should have_field('order_address[billing_zip]', with: "") }
    it { should have_field('order_address[billing_phone]', with: "+380") }
  end

  describe "when user has no shipping address" do
    it { should have_field('order_address[shipping_first_name]', with: "") }
    it { should have_field('order_address[shipping_last_name]', with: "") }
    it { should have_field('order_address[shipping_address]', with: "") }
    it { should have_field('order_address[shipping_city]', with: "") }
    it { should have_field('order_address[shipping_zip]', with: "") }
    it { should have_field('order_address[shipping_phone]', with: "+380") }
  end

  describe "when user has billing address" do
    before(:each) do
      FactoryGirl.create(:billing_address, user_id: user.id)
      visit checkout_addresses_path
    end
    it "should prefill billing address form fields" do
      billing_address = BillingAddress.find_by user_id: user.id
      expect(page).to have_field('order_address[billing_first_name]', with: billing_address[:first_name])
      expect(page).to have_field('order_address[billing_last_name]', with: billing_address[:last_name])
      expect(page).to have_field('order_address[billing_address]', with: billing_address[:address])
      expect(page).to have_field('order_address[billing_city]', with: billing_address[:city])
      expect(page).to have_field('order_address[billing_zip]', with: billing_address[:zip])
      expect(page).to have_field('order_address[billing_phone]', with: billing_address[:phone])
    end
  end

  describe "when user has shipping address" do
    before(:each) do
      FactoryGirl.create(:shipping_address, user_id: user.id)
      visit checkout_addresses_path
    end
    it "should prefill shipping address form fields" do
      shipping_address = ShippingAddress.find_by user_id: user.id
      expect(page).to have_field('order_address[shipping_first_name]', with: shipping_address[:first_name])
      expect(page).to have_field('order_address[shipping_last_name]', with: shipping_address[:last_name])
      expect(page).to have_field('order_address[shipping_address]', with: shipping_address[:address])
      expect(page).to have_field('order_address[shipping_city]', with: shipping_address[:city])
      expect(page).to have_field('order_address[shipping_zip]', with: shipping_address[:zip])
      expect(page).to have_field('order_address[shipping_phone]', with: shipping_address[:phone])
    end
  end

  # describe "when user clicks checkbox 'Use Billing Address'", js: true do
  #   before(:each) do
  #     visit checkout_addresses_path
  #   end
  #   it "should disappear shipping address form" do
  #     page.find('label.checkbox-label.use-billing-address').click
  #     expect(page).not_to have_selector('.shipping-address-container-checkout')
  #   end
  # end

  describe "when user filling in forms with invalid data" do
    before(:each) do
      visit checkout_addresses_path
    end
    it "should not save order address" do
      order_id = find("#order_address_order_id", visible: false).value
      click_button("Save and Continue")
      expect(OrderAddress.find_by order_id: order_id).to be_nil
    end
  end 

  describe "when user filling in forms with valid data" do
    before(:each) do
      visit checkout_addresses_path
    end
    it "should save order address" do
      order_id = find("#order_address_order_id", visible: false).value
      within('div.billing-address-container-checkout') do
        fill_in I18n.t('settings_page.first_name'), with: "Test"
        fill_in I18n.t('settings_page.last_name'), with: "Test"
        fill_in I18n.t('settings_page.address'), with: "Test, 1"
        fill_in I18n.t('settings_page.city'), with: "Test"
        fill_in I18n.t('settings_page.zip'), with: "123456"
        select "Ukraine", from: "order_address_billing_country"
        fill_in I18n.t('settings_page.phone'), with: "+1111111111"
      end
      within('div.shipping-address-container-checkout') do
        fill_in I18n.t('settings_page.first_name'), with: "Test"
        fill_in I18n.t('settings_page.last_name'), with: "Test"
        fill_in I18n.t('settings_page.address'), with: "Test, 1"
        fill_in I18n.t('settings_page.city'), with: "Test"
        fill_in I18n.t('settings_page.zip'), with: "123456"
        select "Ukraine", from: "order_address_shipping_country"
        fill_in I18n.t('settings_page.phone'), with: "+1111111111"
      end
      first('input#order_address_order_id', visible: false).set(order_id)

      click_button("Save and Continue")
      expect(OrderAddress.find_by order_id: order_id).not_to be_nil
    end
  end  

end
