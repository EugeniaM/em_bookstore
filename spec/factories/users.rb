FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "Testtest1"
    password_confirmation "Testtest1"
    coupon_code "1234567"
  end
end
