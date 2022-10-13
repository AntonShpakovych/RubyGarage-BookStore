# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :order_items

  def subtotal_price
    order_items.sum { |item| item.quantity * item.book_price }
  end

  def discount
    coupon ? subtotal_price * coupon.discount / Constants::Coupon::MAX_DISCOUNT : Constants::Coupon::MIN_DISCOUNT
  end

  def total_price
    subtotal_price - discount
  end
end
