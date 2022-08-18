# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    price { Faker::Commerce.price(range: 0..100.0) }
    description { Faker::Lorem.paragraph_by_chars(number: 500) }
    height { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    width { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    length { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    quantity { Faker::Number.between(from: 1, to: 100) }
    year_of_publication { Faker::Date.backward(days: 10_000).year }
    materials { Faker::Construction.material }
    category
  end
end
