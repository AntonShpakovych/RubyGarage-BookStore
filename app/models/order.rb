# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { unprocessed: 0 }
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
end
