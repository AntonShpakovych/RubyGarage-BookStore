# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :book_quantity_less, only: [:update], unless: :order_items_service

  def create
    message = order_item_exist? ? t('carts.message.create_bad') : t('carts.message.create_good')
    return redirect_with_flash(alert: message) if order_item_exist?

    call_sevice_with_redirect(notice: message)
  end

  def update
    call_sevice_with_redirect(notice: t('carts.message.update'))
  end

  def destroy
    OrderItem.find_by(id: params[:id])&.destroy
    redirect_with_flash(notice: t('carts.message.delete'))
  end

  private

  def order_items_service
    @order_items_service ||= OrderItemsService.new(order: current_order, params: permitted_params).call
  end

  def call_sevice_with_redirect(notice: nil, alert: nil)
    order_items_service
    redirect_with_flash(notice: notice, alert: alert)
  end

  def redirect_with_flash(notice: nil, alert: nil)
    flash_options = { notice: notice, alert: alert }.compact_blank
    redirect_to cart_path, **flash_options
  end

  def book_quantity_less
    redirect_with_flash(alert: t('carts.message.book_quantity_less'))
  end

  def order_item_exist?
    @order_item_exist ||= current_order.order_items.find_by(book_id: permitted_params[:book_id])
  end

  def permitted_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
