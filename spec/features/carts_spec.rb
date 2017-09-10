require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Carts" do
  subject { page }

  begin
    order_status = OrderStatus.find(1)
  rescue
    order_status = FactoryGirl.create(:order_status, id: 1)
  end
  user = FactoryGirl.create(:user)
  current_order = FactoryGirl.create(:order, order_status: order_status, user: user)
  book = FactoryGirl.create(:book, price: 20)
  let(:order_item) { FactoryGirl.create(:order_item, order: current_order, book: book) }
  let(:last_added_books) { FactoryGirl.create_list(:book, 3, price: 20) }

  before(:each) do
    visit cart_path
  end

  it { should have_selector('h1.general-title-margin', text: I18n.t('cart_page.cart_title')) }

  it { should have_selector('.text-center.no-items') }


  describe "when there are items in a cart" do
    before(:each) do
      visit root_path
      @last_added_books = last_added_books
      first('.carousel-buy-link').click
      visit cart_path
    end

    it "should render decrement and increment links and subtotal and total values" do
      expect(page).to have_selector('.quantity-link')
      expect(page).to have_selector('p.font-16.subtotal', text: "€20.0")
      expect(page).to have_selector('strong.font-18.total', text: "€20.0")
    end
      
    it "should increase quantity of a book when increment link is clicked", js: true do
      first(:link, '+').click
      expect(page).to have_field("quantity", with: 2)
    end

    it "should not decrease quantity of a book when decrement link is clicked if quantity is 1", js: true do
      first(:link, '-').click
      expect(page).not_to have_field("quantity", with: 0)
    end

    it "should not decrease quantity of a book when decrement link is clicked if quantity is more than 1", js: true do
      first(:link, '+').click
      first(:link, '-').click
      expect(page).to have_field("quantity", with: 1)
    end

    # it "should add 5% discount if valid coupon number was provided", js: true do
    #   within('.general-order-wrap') do 
    #     find('#discount-input').set('1234567')
    #     first('span.btn-title').click
    #     expect(page).to have_selector('p.font-16.subtotal', text: "€20.0")
    #     expect(page).to have_selector('p.font-16.discount', text: "€1.0")
    #     expect(page).to have_selector('strong.font-18.total', text: "€19.0")
    #   end
    # end

    it "should redirect to checkout_address page when 'Checkout' button clicked" do
      first(:link, I18n.t('cart_page.checkout')).click
      expect(page).to have_selector("h3.guest-identify-title")
    end
  end
end
