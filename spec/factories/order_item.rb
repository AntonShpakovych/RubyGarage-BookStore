# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    book
    order
    quantity { 1 }
  end
end
