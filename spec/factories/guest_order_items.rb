FactoryGirl.define do
  factory :guest_order_item do
    association :guest_order_id, factory: :guest_order
    association :book_id, factory: :book
    unit_price 1.5
    total_price 1.5
    quantity 1
  end
end
