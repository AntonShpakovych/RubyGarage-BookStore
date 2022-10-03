# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :order_items

  def subtotal
    order_items.sum { |item| item.quantity * item.book.price }
  end
end
