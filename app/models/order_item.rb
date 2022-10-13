# frozen_string_literal: true

class OrderItem < ApplicationRecord
  MIN_QUANTITY = 1

  belongs_to :order
  belongs_to :book

  validates :quantity, numericality: { greater_than_or_equal_to: MIN_QUANTITY }
end
