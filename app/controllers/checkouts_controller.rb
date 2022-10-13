# frozen_string_literal: true

class CheckoutsController < ApplicationController
  def show
    @state = current_user ? state : need_authorization
  end

  private

  def state
    current_user.orders.find_by(status: status).state
  end

  def need_authorization
    Constants::Checkout::STATE_FOR_NOT_AUTHORIZATION_USER
  end

  def status
    Order.statuses.fetch(:unprocessed)
  end
end
