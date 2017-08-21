require 'rails_helper'

RSpec.describe Order do
  user = FactoryGirl.create(:user)
  let(:order) { FactoryGirl.create(:order, user: user) }

  subject { order }

  describe "when order is created" do
    it "should have order_status_id equal to 1" do
      expect(order.order_status_id).to eq 1
    end

    it "should have user settled" do
      expect(order.user).not_to be_nil
    end

    it "should have subtotal equal to 0" do
      expect(order.subtotal).to eq 0
    end

    it "should have total equal to 0" do
      expect(order.total).to eq 0
    end
  end

  describe "when order_item is added to order" do
    before(:each) do
      book = FactoryGirl.create(:book, price: 20)
      order_item = FactoryGirl.create(:order_item, order: order, book: book)
      order.order_items = [order_item]
    end

    it "should have subtotal equal to 20" do
      expect(order.subtotal).to eq 20
    end

    it "should have total equal to 20" do
      expect(order.total).to eq 20
    end
  end

  describe "when discount is settled" do
    before(:each) do
      book = FactoryGirl.create(:book, price: 20)
      order_item = FactoryGirl.create(:order_item, order: order, book: book)
      order.order_items = [order_item]
      order.discount = 5
    end

    it "should have subtotal equal to 20" do
      expect(order.subtotal).to eq 20
    end

    it "should have total equal to 20" do
      expect(order.total).to eq 20 * 0.95
    end
  end

end
