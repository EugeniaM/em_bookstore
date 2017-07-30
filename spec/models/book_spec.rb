require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe Book do
  let(:book) { FactoryGirl.create(:book) }
  
  subject { book }

  describe "when title is not present" do
    before { book.title = " " }
    it { should_not be_valid }
  end

  describe "when short_description is not present" do
    before { book.short_description = " " }
    it { should_not be_valid }
  end

  describe "when full_description is not present" do
    before { book.full_description = " " }
    it { should_not be_valid }
  end

  describe "when price is not present" do
    before { book.price = nil }
    it { should_not be_valid }
  end

  describe "when category_id is not present" do
    before { book.category_id = " " }
    it { should_not be_valid }
  end

  describe "when all required fields are present" do
    it { should be_valid }
  end  
end
