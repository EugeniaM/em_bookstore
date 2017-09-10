FactoryGirl.define do
  factory :payment_card do
    card_number "1111111111111111"
    name "Test"
    expiry_date "12/25"
    cvv "111"
    association :order_id, factory: :order
  end
end
