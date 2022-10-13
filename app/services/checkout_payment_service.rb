# frozen_string_literal: true

class CheckoutPaymentService < CheckoutApplicationService
  attr_reader :user, :order, :params

  def call
    order.to_confirm! if credit_card_form.save
    send_form
  end

  private

  def credit_card_form
    @credit_card_form ||= CreditCardForm.new(credit_card, payment_params)
  end

  def credit_card
    @credit_card ||= CreditCard.find_or_initialize_by(order_id: payment_params[:order_id])
  end

  def payment_params
    params.require(:payment).permit(:number, :name, :date, :cvv).merge(order_id: order.id)
  end

  def send_form
    credit_card_form
  end
end
