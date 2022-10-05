# frozen_string_literal: true

class CouponForm < ApplicationForm
  attr_accessor :order_id

  validate :unique_order

  private

  def unique_order
    errors.add(:order_id, message: I18n.t('carts.message.invalid_coupon')) if @model.order
  end
end
