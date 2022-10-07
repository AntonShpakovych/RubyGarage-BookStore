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
      guess_order
    elsif merged_order_service_call.present?
      merged_order_service_call
    elsif user_order.present?
      user_order
    else
      create_order_with_or_without_user(user&.id)
    end
  end

  private

  def merged_order_service_call
    @merged_order_service_call ||= OrderMergeService.new(user: user,
                                                         guess_order: guess_order,
                                                         cookies: cookies, user_order: user_order).call
  end

  def create_order_with_or_without_user(user_id)
    order = Order.create(user_id: user_id)
    cookies[:order_id] = order.id unless user_id
    order
  end

  def guess_order
    Order.find_by(id: cookies[:order_id])
  end

  def user_order
    user&.orders&.find_by(status: Order.statuses.fetch(:unprocessed))
  end
end
