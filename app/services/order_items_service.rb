# frozen_string_literal: true

class OrderItemsService
  attr_reader :order, :params

  DEFAULT_QUANTITY_INCREMENT = 1

  def initialize(order:, params:)
    @order = order
    @params = params
  end

  def call
    order_item ? update_order_item : create_order_item
  end

  def order_item
    @order_item ||= order.order_items.find_by(book: params[:book_id])
  end

  def update_order_item
    return if user_want_more_book_when_we_have

    order_item.quantity < DEFAULT_QUANTITY_INCREMENT ? order_item.delete : order_item.save
  end

  def create_order_item
    order.order_items.create(params)
  end

  def order_item_quantity_increase
    order_item.quantity += params[:quantity].to_i
  end

  def user_want_more_book_when_we_have
    order_item_quantity_increase > order_item.book.quantity
  end
end
