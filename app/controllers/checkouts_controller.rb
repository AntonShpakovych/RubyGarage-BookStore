# frozen_string_literal: true

class CheckoutsController < ApplicationController
  def show
    @state = current_user ? state : need_authorization
    @current_order = decorate_current_order
  end

  def update
    @form = checkout_service
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
end
