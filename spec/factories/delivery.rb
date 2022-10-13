# frozen_string_literal: true

FactoryBot.define do
  factory :delivery do
    name { FFaker::Name.first_name }
    price { rand(0..100.0).ceil(2) }
    from_date { Faker::Number.between(from: 2, to: 10) }
    to_date { Faker::Number.between(from: 2, to: 10) }

    trait :orders do
      [order]
    end
  end
end
