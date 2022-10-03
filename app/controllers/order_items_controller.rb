# frozen_string_literal: true

class OrderItemsController < ApplicationController
  def create
    call_sevice_with_redirect(:create)
  end

  def update
    call_sevice_with_redirect(:update)
  end

  private

  def order_service
    @order_service = OrderService.new(order: current_order, user: current_user, cookies: cookies).call
  end

  def order_items_service
    OrderItemsService.new(order: order_service, params: permitted_params)
  end

  def call_sevice_with_redirect(method)
    order_items_service.call

    if method == :create
      redirect_to books_path
    else
      redirect_to cart_path
    end
  end

  def permitted_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
