# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { FFaker::Book.title }
    text { FFaker::Book.description }
    rating { (ReviewForm::MIN_RATING..ReviewForm::MAX_RATING).to_a.sample }
    book
    user
  end
end
