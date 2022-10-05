# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    trait :order_items do
      order_items do
        [FactoryBot.create(:order_item)]
      end
    end

    trait :user do
      user
    end

    trait :with_coupon do
      coupon
    end
  end
end
