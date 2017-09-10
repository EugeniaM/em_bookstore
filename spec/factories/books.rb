FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    short_description { Faker::Lorem.sentence }
    full_description { Faker::Lorem.paragraph }
    price { Faker::Number.decimal(2) }
    association :category, factory: :category

    after :create do |b|
      b.update_column(:covers, ["../../public/test_cover.jpeg"])
    end
  end
end
