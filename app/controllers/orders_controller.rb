# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = order_query_call.decorate
    @current_status = order_query.status
  end

  def show
    @order = Order.find_by(id: params[:id]).decorate
  end

  private

  def order_query_call
    order_query.call
  end

  def order_query
    @order_query ||= OrderQuery.new(params, current_user.orders)
  end
end
