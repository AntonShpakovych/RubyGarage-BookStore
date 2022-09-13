# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::AddressUS.street_address }
    city { 'City' }
    zip { FFaker::AddressUS.zip_code }
    country { ISO3166::Country.all.sample.alpha2 }
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
