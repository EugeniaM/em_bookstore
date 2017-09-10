FactoryGirl.define do
  factory :guest_order do
    association :order_status_id, factory: :order_status
    total 1.5
    subtotal 1.5
    session_id "MyString"
  end
end
