FactoryGirl.define do
  factory :shipping_address do
    first_name "Steve"
    last_name "Jobs"
    address "12 Gorkogo str"
    city "Dnipro"
    zip { Faker::Address.zip }
    country "UA"
    phone "+1333333333"
    association :user, factory: :user
  end
end
