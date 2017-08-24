require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe Author do
  let(:author) { FactoryGirl.create(:author) }
  
  subject { author }

  describe "when first_name is not present" do
    before { author.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last_name is not present" do
    before { author.last_name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { author.description = " " }
    it { should_not be_valid }
  end

  describe "when first_name and last_name format is invalid" do
    let(:names) { %w[test! test1 'a'*51] }
    
    it "first_name should be invalid" do
      names.each do |invalid_name|
        author.first_name = invalid_name
        expect(author).not_to be_valid
      end
    end

    it "last_name should be invalid" do
      names.each do |invalid_name|
        author.last_name = invalid_name
        expect(author).not_to be_valid
      end
    end
  end

  describe "when first_name and last_name format is valid" do
    let(:names) { ["test", "test.", "test. test", "test test", 'a'*50] }
    
    it "first_name should be invalid" do
      names.each do |valid_name|
        author.first_name = valid_name
        expect(author).to be_valid
      end
    end

    it "last_name should be invalid" do
      names.each do |valid_name|
        author.last_name = valid_name
        expect(author).to be_valid
      end
    end
  end

end
