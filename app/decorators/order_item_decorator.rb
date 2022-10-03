# frozen_string_literal: true

class OrderItemDecorator < Draper::Decorator
  delegate_all

  def subtotal_price
    quantity * book.price
  end
end
