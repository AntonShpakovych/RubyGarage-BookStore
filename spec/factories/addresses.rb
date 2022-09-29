# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_name }
    city { FFaker::Address.city }
    zip { FFaker::Address.zip_code }
    country { 'UA' }
    phone { "+#{ISO3166::Country[country].country_code}#{Faker::Number.number(digits: AddressForm::PHONE_MIN_LENGTH)}" }
    user

    trait :shipping_address do
      type { 'ShippingAddress' }
    end

    trait :billing_address do
      type { 'BillingAddress' }
    end
  end
end
