# frozen_string_literal: true

class CheckoutDeliveryService < CheckoutApplicationService
  attr_reader :user, :order, :params

  def call
    add_delivery_to_order
    order.to_payment!
  end

  private

  def add_delivery_to_order
    order.update(delivery_id: params[:delivery_id])
  end
end
