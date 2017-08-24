require 'rails_helper'

RSpec.describe GuestOrder, type: :model do
  begin
    order_status = OrderStatus.find(1)
  rescue
    order_status = FactoryGirl.create(:order_status, id: 1)
  end
  let(:guest_order) { FactoryGirl.create(:guest_order, order_status: order_status) }

  subject { guest_order }

  describe "when guest_order is created" do
    it "should have order_status_id equal to 1" do
      expect(guest_order.order_status_id).to eq 1
    end

    it "should have subtotal equal to 0" do
      expect(guest_order.subtotal).to eq 0
    end

    it "should have total equal to 0" do
      expect(guest_order.total).to eq 0
    end
  end

  describe "when guest_order_item is added to guest_order" do
    before(:each) do
      book = FactoryGirl.create(:book, price: 20)
      guest_order_item = FactoryGirl.create(:guest_order_item, guest_order: guest_order, book: book)
      guest_order.guest_order_items = [guest_order_item]
    end

    it "should have subtotal equal to 20" do
      expect(guest_order.subtotal).to eq 20
    end

    it "should have total equal to 20" do
      expect(guest_order.total).to eq 20
    end
  end

  describe "when discount is settled" do
    before(:each) do
      book = FactoryGirl.create(:book, price: 20)
      guest_order_item = FactoryGirl.create(:guest_order_item, guest_order: guest_order, book: book)
      guest_order.guest_order_items = [guest_order_item]
      guest_order.discount = 5
    end

    it "should have subtotal equal to 20" do
      expect(guest_order.subtotal).to eq 20
    end

    it "should have total equal to 20" do
      expect(guest_order.total).to eq 20 * 0.95
    end
  end
end
