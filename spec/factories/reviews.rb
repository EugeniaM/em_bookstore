FactoryGirl.define do
  factory :review do
    title "MyString"
    text "MyString"
    score 1
    status "Unprocessed"
    verified false
    association :user_id, factory: :user
    association :book_id, factory: :book
  end
end
