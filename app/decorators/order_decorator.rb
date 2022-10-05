# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  MAX_DISCOUNT = 100
  DEFAULT_DISCOUNT = 0

  delegate_all
  decorates_association :order_items

  def subtotal
    order_items.sum { |item| item.quantity * item.book.price }
  end

  def discount
    coupon ? subtotal * coupon.discount / MAX_DISCOUNT : DEFAULT_DISCOUNT
  end

  def order_total
    subtotal - discount
  end
end
