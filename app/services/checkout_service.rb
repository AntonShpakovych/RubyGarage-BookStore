# frozen_string_literal: true

class CheckoutService < CheckoutApplicationService
  attr_reader :user, :order, :params

  CHECKOUT_STATE_SERVICES = { address: CheckoutAddressService, delivery: CheckoutDeliveryService }.freeze

  def call
    call_service_for_current_state
  end

  private

  def call_service_for_current_state
    @call_service_for_current_state ||= CHECKOUT_STATE_SERVICES[order.aasm.current_state].new(user, order, params).call
  end
end
