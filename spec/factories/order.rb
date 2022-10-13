# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    number { FFaker::Identification.drivers_license }

    trait :order_items do
      order_items do
        [FactoryBot.create(:order_item)]
      end
    end

    trait :user do
      user
    end

    trait :coupon do
      coupon
    end

    trait :delivery do
      delivery
    end

    trait :credit_card do
      credit_card
    end
  end
end
