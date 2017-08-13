FactoryGirl.define do
  factory :review do
    title "MyString"
    text "MyString"
    score 1
    status "MyString"
    verified false
    user_id 1
    book_id 1
  end
end
