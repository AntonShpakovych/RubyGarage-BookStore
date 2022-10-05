# frozen_string_literal: true

class OrderItemsController < ApplicationController
  def create
    message = order_item_exist? ? t('carts.message.create_bad') : t('carts.message.create_good')
    return redirect_to books_path, alert: message if order_item_exist?

    call_sevice_with_redirect(notice: message)
  end

  def update
    call_sevice_with_redirect(notice: t('carts.message.update'))
  end

  def destroy
    OrderItem.find_by(id: params[:id].to_i).destroy
    redirect_to cart_path, notice: t('carts.message.delete')
  end

  private

  def order_items_service
    @order_items_service ||= OrderItemsService.new(order: @current_order, params: permitted_params)
  end

  def call_sevice_with_redirect(notice)
    return redirect_to cart_path, alert: t('carts.message.book_quanity_less') if order_items_service.call.nil?

    redirect_to cart_path, notice: notice
  end

  def order_item_exist?
    current_order.order_items.find_by(book_id: permitted_params[:book_id])
  end

  def permitted_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
