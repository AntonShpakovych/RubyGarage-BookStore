# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :order_items

  def subtotal
    order_items.sum { |item| item.quantity * item.book.price }
  end

  def discount
    coupon ? subtotal * coupon.discount / Coupon::MAX_DISCOUNT : Coupon::MIN_DISCOUNT
  end

  def order_total
    subtotal - discount
  end
end
