# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :back_link, unless: :empty_order

  def show
    @state = current_user ? state : need_authorization
    @current_order = decorate_current_order
  end

  def update
    @service = checkout_service
    @current_order = decorate_current_order
    @state = state
    render :show
  end

  private

  def decorate_current_order
    current_order.decorate
  end

  def checkout_service
    @checkout_service ||= CheckoutService.new(current_user, current_order, params).call
  end

  def state
    current_order.state
  end

  def need_authorization
    Constants::Checkout::STATE_FOR_NOT_AUTHORIZATION_USER
  end

  def empty_order
    current_order.order_items.present?
  end

  def back_link
    redirect_to books_path
  end
end
