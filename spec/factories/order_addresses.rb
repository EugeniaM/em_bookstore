FactoryGirl.define do
  factory :order_address do
    billing_first_name "Steve"
    billing_last_name "Jobs"
    billing_address "12 Gorkogo str"
    billing_city "Dnipro"
    billing_zip { Faker::Address.zip }
    billing_country "UA"
    billing_phone "+1333333333"
    shipping_first_name "Steve"
    shipping_last_name "Jobs"
    shipping_address "12 Gorkogo str"
    shipping_city "Dnipro"
    shipping_zip { Faker::Address.zip }
    shipping_country "UA"
    shipping_phone "+1333333333"
    association :order_id, factory: :order
  end
end
