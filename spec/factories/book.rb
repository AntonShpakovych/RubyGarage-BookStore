# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { FFaker::Book.title }
    price { rand(0..100.0).round(2) }
    description { FFaker::CheesyLingo.paragraph }
    height { rand(0..100.0).round(2) }
    width { rand(0..100.0).round(2) }
    length { rand(0..100.0).round(2) }
    quantity { rand(0..100) }
    year_of_publication { FFaker::Vehicle.year }
    materials { FFaker::BaconIpsum.word }
    category
  end
end
