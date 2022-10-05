# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    code { FFaker::Code.ean }
    discount { rand(Coupon::MIN_DISCOUNT..Coupon::MAX_DISCOUNT) }

    trait :order do
      :order
    end
  end
end
