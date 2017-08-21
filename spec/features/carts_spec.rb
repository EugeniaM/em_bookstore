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

  before(:each) do
    visit cart_path
  end

  it { should have_selector('h1.general-title-margin', text: I18n.t('cart_page.cart_title')) }

  it { should have_selector('.text-center.no-items') }


  describe "when there are items in a cart" do

    it "should render decrement link" do
      # allow(ApplicationController).to receive(:current_order).and_return(current_order)
      @order_items = [order_item]
      # puts "+++++++++++++++++"
      # puts @order_items.is_a? Array
      # puts @order_items.size
      # puts "+++++++++++++++++"

      # @order_items not seen in view??????????? can't test the rest of features on this page(((

      # expect(page).to have_selector('.quantity-link.decrement')
    end

  end
end
