# frozen_string_literal: true

class CouponForm
  include ActiveModel::Model
  attr_accessor :order_id, :code

  validate :unique_order

  def initialize(model, params = {})
    self.attributes = params
    @params = params
    @model = model
  end

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
