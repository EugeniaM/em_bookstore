require 'rails_helper'

RSpec.describe ShippingAddress do
  let(:shipping_address) { FactoryGirl.create(:shipping_address) }
  
  subject { shipping_address }

  describe "when first_name is not present" do
    before { shipping_address.first_name = " " }
    it { should_not be_valid }
  end
  
  describe "when last_name is not present" do
    before { shipping_address.last_name = " " }
    it { should_not be_valid }
  end

  describe "when address is not present" do
    before { shipping_address.address = " " }
    it { should_not be_valid }
  end

  describe "when city is not present" do
    before { shipping_address.city = " " }
    it { should_not be_valid }
  end

  describe "when zip is not present" do
    before { shipping_address.zip = " " }
    it { should_not be_valid }
  end

  describe "when country is not present" do
    before { shipping_address.country = " " }
    it { should_not be_valid }
  end

  describe "when phone is not present" do
    before { shipping_address.phone = " " }
    it { should_not be_valid }
  end
  
  describe "when first_name is present" do
    it { should be_valid }
  end
  
  describe "when last_name is present" do
    it { should be_valid }
  end

  describe "when address is present" do
    it { should be_valid }
  end

  describe "when city is present" do
    it { should be_valid }
  end

  describe "when zip is present" do
    it { should be_valid }
  end

  describe "when country is present" do
    it { should be_valid }
  end

  describe "when phone is present" do
    it { should be_valid }
  end

  describe "when first_name, last_name, country and city format is invalid" do
    let(:names) { ['test!', 'test1', 'a'*51] }
    
    it "first_name should be invalid" do
      names.each do |invalid_name|
        shipping_address.first_name = invalid_name
        expect(shipping_address).not_to be_valid
      end
    end

    it "last_name should be invalid" do
      names.each do |invalid_name|
        shipping_address.last_name = invalid_name
        expect(shipping_address).not_to be_valid
      end
    end

    it "country should be invalid" do
      names.each do |invalid_name|
        shipping_address.country = invalid_name
        expect(shipping_address).not_to be_valid
      end
    end

    it "city should be invalid" do
      names.each do |invalid_name|
        shipping_address.city = invalid_name
        expect(shipping_address).not_to be_valid
      end
    end
  end

  describe "when first_name, last_name, country and city format is valid" do
    let(:names) { ["test", "test.", "test. test", "test test", 'a'*50] }
    
    it "first_name should be invalid" do
      names.each do |valid_name|
        shipping_address.first_name = valid_name
        expect(shipping_address).to be_valid
      end
    end

    it "last_name should be invalid" do
      names.each do |valid_name|
        shipping_address.last_name = valid_name
        expect(shipping_address).to be_valid
      end
    end

    it "country should be invalid" do
      names.each do |valid_name|
        shipping_address.country = valid_name
        expect(shipping_address).to be_valid
      end
    end

    it "city should be invalid" do
      names.each do |valid_name|
        shipping_address.city = valid_name
        expect(shipping_address).to be_valid
      end
    end
  end

  describe "when address format is invalid" do
    let(:addresses) { ['test!', "test\\", 'a'*51] }
    
    it "address should be invalid" do
      addresses.each do |invalid_address|
        shipping_address.address = invalid_address
        expect(shipping_address).not_to be_valid
      end
    end
  end

  describe "when address format is valid" do
    let(:addresses) { ['test12', 'test, 15', 'a'*50] }
    
    it "address should be valid" do
      addresses.each do |valid_address|
        shipping_address.address = valid_address
        expect(shipping_address).to be_valid
      end
    end
  end

  describe "when zip format is invalid" do
    let(:zips) { ['test', "123as", '123#', '123!', '123[-', '1'*11] }
    
    it "zip should be invalid" do
      zips.each do |invalid_zip|
        shipping_address.zip = invalid_zip
        expect(shipping_address).not_to be_valid
      end
    end
  end

  describe "when zip format is valid" do
    let(:zips) { ['123456', "123-123", '1'*10] }
    
    it "zip should be valid" do
      zips.each do |valid_zip|
        shipping_address.zip = valid_zip
        expect(shipping_address).to be_valid
      end
    end
  end

  describe "when phone format is invalid" do
    let(:phones) { ['test', "123", '+123df', '+123!', '123+', '1'*16] }
    
    it "phone should be invalid" do
      phones.each do |invalid_phone|
        shipping_address.phone = invalid_phone
        expect(shipping_address).not_to be_valid
      end
    end
  end

  describe "when phone format is valid" do
    let(:phones) { ['+1234567890', "+11111111111111", ] }
    
    it "phone should be invalid" do
      phones.each do |valid_phone|
        shipping_address.phone = valid_phone
        expect(shipping_address).to be_valid
      end
    end
  end
end
