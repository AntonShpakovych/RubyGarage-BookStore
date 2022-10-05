# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :all_category, :current_order, :cart_count

  def current_order
    @current_order ||= OrderService.new(current_user, cookies).call
  end

  def cart_count
    @cart_count ||= current_order ? current_order.order_items.sum(&:quantity) : 0
  end

  def all_category
    @all_category ||= Category.all
  end
end
