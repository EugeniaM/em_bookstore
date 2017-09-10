require 'rails_helper'

RSpec.describe GuestOrderItem do
  begin
    order_status = OrderStatus.find(1)
  rescue
    order_status = FactoryGirl.create(:order_status, id: 1)
  end
  guest_order = FactoryGirl.create(:guest_order, order_status: order_status)
  book = FactoryGirl.create(:book, price: 20)

  let(:guest_order_item) { FactoryGirl.create(:guest_order_item, guest_order: guest_order, book: book) }

  subject { guest_order_item }

  describe "when quantity is not present" do
    before { guest_order_item.quantity = " " }
    it { should_not be_valid }
  end

  describe "when quantity is 0" do
    before { guest_order_item.quantity = 0 }
    it { should_not be_valid }
  end

  describe "when quantity is not integer" do
    before { guest_order_item.quantity = 1.5 }
    it { should_not be_valid }
  end

  describe "when quantity is integer greater than 0" do
    it { should be_valid }
  end

  describe "when book is not present" do
    before { guest_order_item.book = nil }
    it { should_not be_valid }
  end

  describe "when book is present" do
    it { should be_valid }
  end

  describe "when order is not present" do
    before { guest_order_item.guest_order = nil }
    it { should_not be_valid }
  end

  describe "when order is present" do
    it { should be_valid }
  end

  describe "when created with 1 book priced 20" do
    it "should have unit_price equal 20" do
      expect(guest_order_item.unit_price).to eq 20
    end

    it "should have total_price equal 20" do
      expect(guest_order_item.total_price).to eq 20
    end
  end

  describe "when created with 2 books priced 20 each" do
    before(:each) { guest_order_item.quantity = 2 }
    it "should have unit_price equal 20" do
      expect(guest_order_item.unit_price).to eq 20
    end

    it "should have total_price equal 40" do
      expect(guest_order_item.total_price).to eq 40
    end
  end
end
