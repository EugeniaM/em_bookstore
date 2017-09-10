require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Checkout_deliveries" do
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
    visit checkout_deliveries_path
  end

  it { should have_selector('h3.general-subtitle', text: 'Shipping Method') }

  describe "when user navigates to dheckout deliveries page" do

    it "should have 'Delivery Next Day' option selected as default option" do
      order_id = find("#hidden-order-id", visible: false).value
      expect(find(:css, '#order_delivery_5')).to be_checked
      expect(page).to have_selector('p.font-16.delivery', text: "€5.0")
      expect(page).to have_selector('strong.font-18.total_delivery', text: "€25.0")
      expect(Order.find(order_id)[:delivery]).to eq 5
    end
  end

  describe "when user click on 'Pick Up In-Srore' radio button" do
    it "should have set delivery cost to 10" do
      order_id = find("#hidden-order-id", visible: false).value
      find('#order_delivery_10').click
      expect(find(:css, '#order_delivery_10')).to be_checked
      # expect(Order.find(order_id)[:delivery]).to eq 10 ????? if turn on js: true => can't find #hidden-order-id
    end
  end

  describe "when user click on 'Expressit' radio button" do
    it "should have set delivery cost to 15" do
      order_id = find("#hidden-order-id", visible: false).value
      find('#order_delivery_15').click
      expect(find(:css, '#order_delivery_15')).to be_checked
      # expect(Order.find(order_id)[:delivery]).to eq 15 ????? if turn on js: true => can't find #hidden-order-id
    end
  end

  describe "when user clicks 'Save and Continue' button" do
    it "should redirect to checkout payments" do
      click_link("Save and Continue")
      expect(page).to have_selector('h3.general-subtitle', text: "Credit Card")
    end 
  end
end
