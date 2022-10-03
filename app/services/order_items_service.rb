# frozen_string_literal: true

class OrderItemsService
  attr_reader :order, :params, :order_item

  DEFAULT_QUANTITY_INCREMENT = 1

  def initialize(order:, params:)
    @order = order
    @params = params
  end

  def call
    find_order_item ? update_order_item : create_order_item
  end

  def find_order_item
    @order_item = order.order_items.find_by(book: params[:book_id])
  end

  def update_order_item
    order_item.quantity += params[:quantity].to_i
    order_item.save
  end

  def create_order_item
    order.order_items.create(params)
  end
end
