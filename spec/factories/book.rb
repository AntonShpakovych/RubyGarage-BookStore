# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { FFaker::Book.title }
    price { rand(0..100.0).ceil(2) }
    description { FFaker::CheesyLingo.paragraph + FFaker::CheesyLingo.paragraph }
    height { FFaker::Number.decimal }
    width { FFaker::Number.decimal }
    length { FFaker::Number.decimal }
    quantity { FFaker::Number.number }
    year_of_publication { FFaker::Vehicle.year }
    materials { FFaker::BaconIpsum.word }
    category
  end
end
