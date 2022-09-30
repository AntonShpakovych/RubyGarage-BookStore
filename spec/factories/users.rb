# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    provider { 'google' }
    uid { rand(10**10) }
    password { FFaker::Internet.password(9, 16) }
    image { FFaker::Image.url }
    full_name { FFaker::Name.name }
  end
end
