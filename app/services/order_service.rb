# frozen_string_literal: true

class OrderService
  attr_accessor :cookies
  attr_reader :user

  def initialize(user, cookies)
    @user = user
    @cookies = cookies
  end

  def call
    return Order.find_by(id: cookies[:order_id].to_i) if !user && cookies[:order_id].present?

    return order_find_by_status if user && order_find_by_status.present?

    create_order_with_or_without_user(user&.id)
  end

  private

  def create_order_with_or_without_user(id)
    order = Order.create(user_id: id)
    cookies[:order_id] = order.id unless id
    order
  end

  def order_find_by_status
    user.orders.find_by(status: :unprocessed)
  end
end
