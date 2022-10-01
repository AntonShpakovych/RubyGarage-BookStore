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
    main_image do
      path = Rails.root.join('spec/fixtures/images/main_image.jpg')
      Rack::Test::UploadedFile.new(path, 'image/jpg')
    end
    images do
      path = Rails.root.join('spec/fixtures/images/images.jpg')
      [Rack::Test::UploadedFile.new(path, 'image/jpg')]
    end
    category
  end
end
