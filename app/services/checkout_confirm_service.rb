# frozen_string_literal: true

class CheckoutConfirmService < CheckoutApplicationService
  attr_reader :user, :order, :params

  ALLOWED_STATE = Order.states
  ROLLBACK_STATE = { 'address' => ->(order) { order.address! },
                     'delivery' => ->(order) { order.delivery! },
                     'payment' => ->(order) { order.payment! } }.freeze

  def call
    return complete if confirmed?

    roll_back
  end

  private

  def roll_back
    ROLLBACK_STATE[checkouts_state].call(order) if ALLOWED_STATE.include?(checkouts_state)
    nil
  end

  def complete
    order.to_complete!
    ConfirmedOrderMailer.confirm_order_email(user.email)
    order.in_queue!
    order.update(number: number)
  end

  def number
    SecureRandom.uuid
  end

  def confirmed?
    params[:confirm].presence
  end

  def checkouts_state
    params[:state].presence
  end
end
