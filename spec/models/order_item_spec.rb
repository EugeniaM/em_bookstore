require 'rails_helper'

RSpec.describe OrderItem do
  begin
    order_status = OrderStatus.find(1)
  rescue
    order_status = FactoryGirl.create(:order_status, id: 1)
  end
  user = FactoryGirl.create(:user)
  order = FactoryGirl.create(:order, order_status: order_status, user: user)
  book = FactoryGirl.create(:book, price: 20)

  let(:order_item) { FactoryGirl.create(:order_item, order: order, book: book) }

  subject { order_item }

  describe "when quantity is not present" do
    before { order_item.quantity = " " }
    it { should_not be_valid }
  end

  describe "when quantity is 0" do
    before { order_item.quantity = 0 }
    it { should_not be_valid }
  end

  describe "when quantity is not integer" do
    before { order_item.quantity = 1.5 }
    it { should_not be_valid }
  end

  describe "when quantity is integer greater than 0" do
    it { should be_valid }
  end

  describe "when book is not present" do
    before { order_item.book = nil }
    it { should_not be_valid }
  end

  describe "when book is present" do
    it { should be_valid }
  end

  describe "when order is not present" do
    before { order_item.order = nil }
    it { should_not be_valid }
  end

  describe "when order is present" do
    it { should be_valid }
  end

  describe "when created with 1 book priced 20" do
    it "should have unit_price equal 20" do
      expect(order_item.unit_price).to eq 20
    end

    it "should have total_price equal 20" do
      expect(order_item.total_price).to eq 20
    end
  end

  describe "when created with 2 books priced 20 each" do
    before(:each) { order_item.quantity = 2 }
    it "should have unit_price equal 20" do
      expect(order_item.unit_price).to eq 20
    end

    it "should have total_price equal 40" do
      expect(order_item.total_price).to eq 40
    end
  end

end
