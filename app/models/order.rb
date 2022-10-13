# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { unprocessed: 0, delivered: 1, canceled: 2 }
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_one :coupon, dependent: :destroy
end
