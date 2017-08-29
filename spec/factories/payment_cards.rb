FactoryGirl.define do
  factory :payment_card do
    card_number "MyString"
    name "MyString"
    expiry_date "MyString"
    cvv "MyString"
    order nil
  end
end
