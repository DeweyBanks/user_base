FactoryGirl.define do
  factory :post do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph
    image Faker::Avatar.image
  end
end
