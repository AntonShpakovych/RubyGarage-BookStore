# frozen_string_literal: true

class OrderQuery
  attr_reader :status, :orders

  def initialize(params, orders)
    @orders = orders
    @status = params[:status]
  end

  def call
    filter_orders
  end

  private

  def filter_orders
    return orders.where(status: status) if status

    orders.where.not(status: Order.statuses.fetch(:unprocessed))
  end
end
