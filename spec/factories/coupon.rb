# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    code { FFaker::Code.ean }
    discount { rand(1..Coupon::MAX_DISCOUNT) }

    trait :order do
      :order
    end
  end
end
