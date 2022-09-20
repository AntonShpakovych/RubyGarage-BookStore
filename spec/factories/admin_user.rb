# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password(9, 16) }
  end
end
