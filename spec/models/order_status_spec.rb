require 'rails_helper'

RSpec.describe OrderStatus, type: :model do
  let(:order_status) { FactoryGirl.create(:order_status) }

  subject { order_status }

  describe "when name is not present" do
    before { order_status.name = " " }
    it { should_not be_valid }
  end

  describe "when name present" do
    it { should be_valid }
  end
end
