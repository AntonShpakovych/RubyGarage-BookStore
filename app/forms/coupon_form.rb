# frozen_string_literal: true

class CouponForm < ApplicationForm
  attr_accessor :order_id, :code

  validate :unique_order

  def save
    return unless valid?

    @model.update(order_id: @params[:order_id])
    @model
  end

  private

  def unique_order
    errors.add(:order_id) if @model.order
  end
end
