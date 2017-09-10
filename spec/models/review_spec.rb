require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe Book do
  let(:book) { FactoryGirl.build(:book) }
  let(:user) { FactoryGirl.build(:user) }
  let(:review) { FactoryGirl.build(:review, user: user, book: book) }
  
  subject { review }

  describe "when title is not present" do
    before { review.title = " " }
    it { should_not be_valid }
  end

  describe "when text is not present" do
    before { review.text = " " }
    it { should_not be_valid }
  end

  describe "when title and text format is invalid" do
    let(:strings) { %w[test\ test[] ] }
    
    it "title should be invalid" do
      strings.each do |invalid_title|
        review.title = invalid_title
        expect(review).not_to be_valid
      end
    end

    it "text should be invalid" do
      strings.each do |invalid_text|
        review.text = invalid_text
        expect(review).not_to be_valid
      end
    end
  end

  describe "when title and text format is valid" do
    let(:strings) { %w[test1234567890 test test!#$%&'*+-/=?^_`{|}~. ] }
    
    it "title should be valid" do
      strings.each do |valid_title|
        review.title = valid_title
        expect(review).to be_valid
      end
    end

    it "text should be valid" do
      strings.each do |valid_text|
        review.text = valid_text
        expect(review).to be_valid
      end
    end
  end

  describe "when title and text length is invalid" do
    it "title should be invalid" do
      review.title = 'a'*81
      expect(review).not_to be_valid
    end

    it "text should be invalid" do
      review.text = 'a'*501
      expect(review).not_to be_valid
    end
  end

  describe "when title and text length is valid" do
    it "title should be valid" do
      review.title = 'a'*80
      expect(review).to be_valid
    end

    it "text should be valid" do
      review.text = 'a'*500
      expect(review).to be_valid
    end
  end
end
