require 'rails_helper'

RSpec.describe PaymentCard do
  begin
    order_status = OrderStatus.find(1)
  rescue
    order_status = FactoryGirl.create(:order_status, id: 1)
  end
  user = FactoryGirl.create(:user)
  order = FactoryGirl.create(:order, order_status: order_status, user: user)
  let(:payment_card) { FactoryGirl.create(:payment_card, order: order) }

  subject { payment_card }

  describe "when card_number is not present" do
    before { payment_card.card_number = " " }
    it { should_not be_valid }
  end
  
  describe "when name is not present" do
    before { payment_card.name = " " }
    it { should_not be_valid }
  end

  describe "when expiry_date is not present" do
    before { payment_card.expiry_date = " " }
    it { should_not be_valid }
  end

  describe "when cvv is not present" do
    before { payment_card.cvv = " " }
    it { should_not be_valid }
  end

  describe "when card_number is present" do
    it { should be_valid }
  end
  
  describe "when name is present" do
    it { should be_valid }
  end

  describe "when expiry_date is present" do
    it { should be_valid }
  end

  describe "when cvv is present" do
    it { should be_valid }
  end

  describe "when card_number format is invalid" do
    let(:numbers) { ['test', 'test1', '1'*17] }
    
    it "card_number should be invalid" do
      numbers.each do |invalid_number|
        payment_card.card_number = invalid_number
        expect(payment_card).not_to be_valid
      end
    end
  end

  describe "when card_number format is invalid" do
    let(:numbers) { ['1'*16] }
    
    it "card_number should be valid" do
      numbers.each do |valid_number|
        payment_card.card_number = valid_number
        expect(payment_card).to be_valid
      end
    end
  end

  describe "when name format is invalid" do
    let(:names) { ['test1', 'dsfsdv-wqdsc'] }
    
    it "name should be invalid" do
      names.each do |invalid_name|
        payment_card.name = invalid_name
        expect(payment_card).not_to be_valid
      end
    end
  end

  describe "when name format is valid" do
    let(:names) { ["test", "test test"] }
    
    it "name should be valid" do
      names.each do |valid_name|
        payment_card.name = valid_name
        expect(payment_card).to be_valid
      end
    end
  end

  describe "when expiry_date format is invalid" do
    let(:expiry_dates) { ['test1', 'qw/qw', '13/13', '00/13'] }
    
    it "expiry_date should be invalid" do
      expiry_dates.each do |invalid_expiry_date|
        payment_card.expiry_date = invalid_expiry_date
        expect(payment_card).not_to be_valid
      end
    end
  end

  describe "when expiry_date format is valid" do
    let(:expiry_dates) { ["11/12", "01/25", "08/15"] }
    
    it "expiry_date should be valid" do
      expiry_dates.each do |valid_expiry_date|
        payment_card.expiry_date = valid_expiry_date
        expect(payment_card).to be_valid
      end
    end
  end

  describe "when cvv format is invalid" do
    let(:cvvs) { ['test1', 'qw/qw', '11111', '1!1'] }
    
    it "cvv should be invalid" do
      cvvs.each do |invalid_cvv|
        payment_card.cvv = invalid_cvv
        expect(payment_card).not_to be_valid
      end
    end
  end

  describe "when cvv format is valid" do
    let(:expiry_dates) { ["111", "1111"] }
    
    it "cvv should be valid" do
      expiry_dates.each do |valid_cvv|
        payment_card.cvv = valid_cvv
        expect(payment_card).to be_valid
      end
    end
  end
end
