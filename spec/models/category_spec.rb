require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe Category do
  let(:category) { FactoryGirl.create(:category) }
  
  subject { category }

  describe "when name is not present" do
    before { category.name = " " }
    it { should_not be_valid }
  end

  describe "when name is present" do
    it { should be_valid }
  end
end
