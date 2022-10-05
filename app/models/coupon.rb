# frozen_string_literal: true

class Coupon < ApplicationRecord
  MIN_DISCOUNT = 1
  MAX_DISCOUNT = 100

  belongs_to :order, optional: true

  validates :code, :discount, presence: true
  validates :discount, numericality: { greater_than_or_equal_to: MIN_DISCOUNT,
                                       less_than_or_equal_to: MAX_DISCOUNT }
end
