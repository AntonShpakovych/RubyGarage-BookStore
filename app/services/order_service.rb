# frozen_string_literal: true

class OrderService
  attr_accessor :order
  attr_writer :cookies
  attr_reader :user

  def initialize(order:, user:, cookies:)
    # prokun tilki id usera
    @order = order
    @user = user
    @cookies = cookies
  end

  def call
    prepared_order
  end

  private

  def prepared_order
    return order if order

    create_order_with_or_without_user(user&.id)
  end

  def create_order_with_or_without_user(user_id)
    order = Order.create(user_id: user_id)
    @cookies[:order_id] = order.id unless user_id
    order
  end
end
