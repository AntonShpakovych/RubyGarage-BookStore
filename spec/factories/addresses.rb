# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    first_name { 'first' }
    last_name { 'last' }
    address { 'address' }
    city { 'Kyiv' }
    zip { '11111' }
    country { 'UA' }
    phone { "+#{ISO3166::Country[country].country_code}#{Faker::Number.number(digits: 9)}" }
    user

    trait :shipping_address do
      type { 'ShippingAddress' }
    end

    trait :billing_address do
      type { 'BillingAddress' }
    end
  end
end
