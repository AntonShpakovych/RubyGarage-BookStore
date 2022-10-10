# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  enum status: { unprocessed: 0, delivered: 1, canceled: 2 }
  enum state: { address: 0, delivery: 1 }

  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_one :coupon, dependent: :destroy

  aasm column: :state, enum: true do
    state :address, initial: true
    state :delivery

    event :to_delivery do
      transitions from: :address, to: :delivery
    end
  end
end
