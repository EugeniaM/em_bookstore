require 'rails_helper'

RSpec.describe OrderAddress do
  begin
    order_status = OrderStatus.find(1)
  rescue
    order_status = FactoryGirl.create(:order_status, id: 1)
  end
  user = FactoryGirl.create(:user)
  order = FactoryGirl.create(:order, order_status: order_status, user: user)
  let(:order_address) { FactoryGirl.create(:order_address, order: order) }
  
  subject { order_address }

  describe "when billing_first_name is not present" do
    before { order_address.billing_first_name = " " }
    it { should_not be_valid }
  end
  
  describe "when billing_last_name is not present" do
    before { order_address.billing_last_name = " " }
    it { should_not be_valid }
  end

  describe "when billing_address is not present" do
    before { order_address.billing_address = " " }
    it { should_not be_valid }
  end

  describe "when billing_city is not present" do
    before { order_address.billing_city = " " }
    it { should_not be_valid }
  end

  describe "when billing_zip is not present" do
    before { order_address.billing_zip = " " }
    it { should_not be_valid }
  end

  describe "when billing_country is not present" do
    before { order_address.billing_country = " " }
    it { should_not be_valid }
  end

  describe "when billing_phone is not present" do
    before { order_address.billing_phone = " " }
    it { should_not be_valid }
  end

  describe "when shipping_first_name is not present" do
    before { order_address.shipping_first_name = " " }
    it { should_not be_valid }
  end
  
  describe "when shipping_last_name is not present" do
    before { order_address.shipping_last_name = " " }
    it { should_not be_valid }
  end

  describe "when shipping_address is not present" do
    before { order_address.shipping_address = " " }
    it { should_not be_valid }
  end

  describe "when shipping_city is not present" do
    before { order_address.shipping_city = " " }
    it { should_not be_valid }
  end

  describe "when shipping_zip is not present" do
    before { order_address.shipping_zip = " " }
    it { should_not be_valid }
  end

  describe "when shipping_country is not present" do
    before { order_address.shipping_country = " " }
    it { should_not be_valid }
  end

  describe "when shipping_phone is not present" do
    before { order_address.shipping_phone = " " }
    it { should_not be_valid }
  end
  
  describe "when billing_first_name is present" do
    it { should be_valid }
  end
  
  describe "when billing_last_name is present" do
    it { should be_valid }
  end

  describe "when billing_address is present" do
    it { should be_valid }
  end

  describe "when billing_city is present" do
    it { should be_valid }
  end

  describe "when billing_zip is present" do
    it { should be_valid }
  end

  describe "when billing_country is present" do
    it { should be_valid }
  end

  describe "when billing_phone is present" do
    it { should be_valid }
  end

  describe "when shipping_first_name is present" do
    it { should be_valid }
  end
  
  describe "when shipping_last_name is present" do
    it { should be_valid }
  end

  describe "when shipping_address is present" do
    it { should be_valid }
  end

  describe "when shipping_city is present" do
    it { should be_valid }
  end

  describe "when shipping_zip is present" do
    it { should be_valid }
  end

  describe "when shipping_country is present" do
    it { should be_valid }
  end

  describe "when shipping_phone is present" do
    it { should be_valid }
  end

  describe "when 
    billing_first_name, 
    billing_last_name, 
    billing_country, 
    billing_city, 
    shipping_first_name, 
    shipping_last_name, 
    shipping_country, 
    shipping_city, 
    format is invalid" do
    let(:names) { ['test!', 'test1', 'a'*51] }
    
    it "billing_first_name should be invalid" do
      names.each do |invalid_name|
        order_address.billing_first_name = invalid_name
        expect(order_address).not_to be_valid
      end
    end

    it "billing_last_name should be invalid" do
      names.each do |invalid_name|
        order_address.billing_last_name = invalid_name
        expect(order_address).not_to be_valid
      end
    end

    it "billing_country should be invalid" do
      names.each do |invalid_name|
        order_address.billing_country = invalid_name
        expect(order_address).not_to be_valid
      end
    end

    it "billing_city should be invalid" do
      names.each do |invalid_name|
        order_address.billing_city = invalid_name
        expect(order_address).not_to be_valid
      end
    end

    it "shipping_first_name should be invalid" do
      names.each do |invalid_name|
        order_address.shipping_first_name = invalid_name
        expect(order_address).not_to be_valid
      end
    end

    it "shipping_last_name should be invalid" do
      names.each do |invalid_name|
        order_address.shipping_last_name = invalid_name
        expect(order_address).not_to be_valid
      end
    end

    it "shipping_country should be invalid" do
      names.each do |invalid_name|
        order_address.shipping_country = invalid_name
        expect(order_address).not_to be_valid
      end
    end

    it "shipping_city should be invalid" do
      names.each do |invalid_name|
        order_address.shipping_city = invalid_name
        expect(order_address).not_to be_valid
      end
    end
  end

  describe "when
    billing_first_name, 
    billing_last_name, 
    billing_country, 
    billing_city, 
    shipping_first_name, 
    shipping_last_name, 
    shipping_country, 
    shipping_city,
    format is valid" do
    let(:names) { ["test", "test.", "test. test", "test test", 'a'*50] }
    
    it "billing_first_name should be invalid" do
      names.each do |valid_name|
        order_address.billing_first_name = valid_name
        expect(order_address).to be_valid
      end
    end

    it "billing_last_name should be invalid" do
      names.each do |valid_name|
        order_address.billing_last_name = valid_name
        expect(order_address).to be_valid
      end
    end

    it "billing_country should be invalid" do
      names.each do |valid_name|
        order_address.billing_country = valid_name
        expect(order_address).to be_valid
      end
    end

    it "billing_city should be invalid" do
      names.each do |valid_name|
        order_address.billing_city = valid_name
        expect(order_address).to be_valid
      end
    end

    it "shipping_first_name should be invalid" do
      names.each do |valid_name|
        order_address.shipping_first_name = valid_name
        expect(order_address).to be_valid
      end
    end

    it "shipping_last_name should be invalid" do
      names.each do |valid_name|
        order_address.shipping_last_name = valid_name
        expect(order_address).to be_valid
      end
    end

    it "shipping_country should be invalid" do
      names.each do |valid_name|
        order_address.shipping_country = valid_name
        expect(order_address).to be_valid
      end
    end

    it "shipping_city should be invalid" do
      names.each do |valid_name|
        order_address.shipping_city = valid_name
        expect(order_address).to be_valid
      end
    end
  end

  describe "when billing_address, shipping_address format is invalid" do
    let(:addresses) { ['test!', "test\\", 'a'*51] }
    
    it "billing_address should be invalid" do
      addresses.each do |invalid_address|
        order_address.billing_address = invalid_address
        expect(order_address).not_to be_valid
      end
    end

    it "shipping_address should be invalid" do
      addresses.each do |invalid_address|
        order_address.shipping_address = invalid_address
        expect(order_address).not_to be_valid
      end
    end
  end

  describe "when billing_address, shipping_address format is valid" do
    let(:addresses) { ['test12', 'test, 15', 'a'*50] }
    
    it "billing_address should be valid" do
      addresses.each do |valid_address|
        order_address.billing_address = valid_address
        expect(order_address).to be_valid
      end
    end

    it "shipping_address should be valid" do
      addresses.each do |valid_address|
        order_address.shipping_address = valid_address
        expect(order_address).to be_valid
      end
    end
  end

  describe "when billing_zip, shipping_zip format is invalid" do
    let(:zips) { ['test', "123as", '123#', '123!', '123[-', '1'*11] }
    
    it "billing_zip should be invalid" do
      zips.each do |invalid_zip|
        order_address.billing_zip = invalid_zip
        expect(order_address).not_to be_valid
      end
    end

    it "shipping_zip should be invalid" do
      zips.each do |invalid_zip|
        order_address.shipping_zip = invalid_zip
        expect(order_address).not_to be_valid
      end
    end
  end

  describe "when billing_zip, shipping_zip format is valid" do
    let(:zips) { ['123456', "123-123", '1'*10] }
    
    it "billing_zip should be valid" do
      zips.each do |valid_zip|
        order_address.billing_zip = valid_zip
        expect(order_address).to be_valid
      end
    end

    it "shipping_zip should be valid" do
      zips.each do |valid_zip|
        order_address.shipping_zip = valid_zip
        expect(order_address).to be_valid
      end
    end
  end

  describe "when billing_phone, shipping_phone format is invalid" do
    let(:phones) { ['test', "123", '+123df', '+123!', '123+', '1'*16] }
    
    it "billing_phone should be invalid" do
      phones.each do |invalid_phone|
        order_address.billing_phone = invalid_phone
        expect(order_address).not_to be_valid
      end
    end

    it "shipping_phone should be invalid" do
      phones.each do |invalid_phone|
        order_address.shipping_phone = invalid_phone
        expect(order_address).not_to be_valid
      end
    end
  end

  describe "when billing_phone, shipping_phone format is valid" do
    let(:phones) { ['+1234567890', "+11111111111111", ] }
    
    it "billing_phone should be invalid" do
      phones.each do |valid_phone|
        order_address.billing_phone = valid_phone
        expect(order_address).to be_valid
      end
    end

    it "shipping_phone should be invalid" do
      phones.each do |valid_phone|
        order_address.shipping_phone = valid_phone
        expect(order_address).to be_valid
      end
    end
  end
end
