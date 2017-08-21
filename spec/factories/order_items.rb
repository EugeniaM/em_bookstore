FactoryGirl.define do
  factory :order_item do
    association :order_id, factory: :order
    association :book_id, factory: :book
    unit_price 0
    total_price 0
    quantity 1
  end
end
