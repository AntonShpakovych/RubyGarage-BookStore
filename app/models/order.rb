# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  enum status: { unprocessed: 0, delivered: 1, canceled: 2 }
  enum state: { address: 0, shipping: 1 }

  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_one :coupon, dependent: :destroy

  aasm column: :state, enum: true do
    state :address, initial: true
    state :shipping

    event :to_shipping do
      transitions from: :address, to: :shipping
    end
  end
end
