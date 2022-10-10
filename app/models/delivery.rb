# frozen_string_literal: true

class Delivery < ApplicationRecord
  has_many :orders, dependent: :destroy
end
