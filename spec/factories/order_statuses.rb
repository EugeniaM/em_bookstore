FactoryGirl.define do
  factory :order_status do
    name { Faker::Lorem.word }
  end
end
