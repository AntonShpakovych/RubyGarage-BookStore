# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { unprocessed: 0, delivered: 3, canceled: 4 }
  enum state: { address: 0 }
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_one :coupon, dependent: :destroy
end
