# frozen_string_literal: true

class OrderService
  attr_accessor :cookies
  attr_reader :user

  def initialize(user, cookies)
    @user = user
    @cookies = cookies
  end

  def call
    if user.blank? && cookies[:order_id].present?
      Order.find_by(id: cookies[:order_id])
    elsif user && order_find_by_status.present?
      order_find_by_status
    else
      create_order_with_or_without_user(user&.id)
    end
  end

  private

  def create_order_with_or_without_user(user_id)
    order = Order.create(user_id: user_id)
    cookies[:order_id] = order.id unless user_id
    order
  end

  def order_find_by_status
    @order_find_by_status ||= user.orders.find_by(status: Order.statuses.fetch(:unprocessed))
  end
end
