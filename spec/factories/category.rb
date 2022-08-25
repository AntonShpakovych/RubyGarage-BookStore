# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { FFaker::Book.genre }

    factory :category_with_books do
      books { [association(:book)] }
    end
  end
end
