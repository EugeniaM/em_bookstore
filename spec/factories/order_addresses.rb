FactoryGirl.define do
  factory :order_address do
    billing_first_name "MyString"
    billing_last_name "MyString"
    billing_address "MyString"
    billing_city "MyString"
    billing_zip "MyString"
    billing_country "MyString"
    billing_phone "MyString"
    shipping_first_name "MyString"
    shipping_last_name "MyString"
    shipping_address "MyString"
    shipping_city "MyString"
    shipping_zip "MyString"
    shipping_country "MyString"
    shipping_phone "MyString"
    order nil
  end
end
