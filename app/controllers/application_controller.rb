# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :all_category, :current_order, :cart_count

  def current_order
    return Order.find_by(id: cookies[:order_id]) unless user_signed_in?

    current_user.orders.find_by(status: :unprocessed)
  end

  def cart_count
    @cart_count ||= current_order ? current_order.order_items.sum(&:quantity) : 0
  end

  def all_category
    @all_category ||= Category.all
  end
end
