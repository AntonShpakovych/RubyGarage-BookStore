# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  enum status: { unprocessed: 0, delivered: 1, canceled: 2 }
  enum state: { address: 0, delivery: 1, payment: 2, confirm: 3 }

  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_many :order_items, dependent: :destroy
  has_one :coupon, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  aasm column: :state, enum: true do
    state :address, initial: true
    state :delivery
    state :payment
    state :confirm

    event :to_delivery do
      transitions from: :address, to: :delivery
    end

    event :to_payment do
      transitions from: :delivery, to: :payment
    end

    event :to_confirm do
      transitions from: :payment, to: :confirm
    end
  end

  def available_delivery
    Delivery.all
  end
end
