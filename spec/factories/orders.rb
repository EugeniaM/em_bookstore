FactoryGirl.define do
  factory :order do
    completed_at "2017-08-13"
    association :order_status_id, factory: :order_status
    total 0
    subtotal 0
    discount 0
    association :user_id, factory: :user
  end
end
