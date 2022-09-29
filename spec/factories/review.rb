# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { FFaker::Book.title }
    text { FFaker::Book.description }
    rating { FFaker::Random.rand(ReviewForm::MIN_RATING..ReviewForm::MAX_RATING) }
    book
    user
  end
end
