# frozen_string_literal: true

class OrderMergeService
  def initialize(user:, guest_order:, cookies:, user_order:)
    @user = user
    @user_order = user_order
    @guest_order = guest_order
    @cookies = cookies
  end

  def call
    return if user.blank? || cookies[:order_id].blank?

    cookies.delete(:order_id)
    merge
  end

  private

  attr_reader :user, :cookies, :guest_order, :user_order

  def merge
    user_order ? drop_user_order : set_user_for_guest_order
  end

  def drop_user_order
    return delete_empty_guest_order if empty_guest_order?

    user_order_preparation
    set_user_for_guest_order
  end

  def set_user_for_guest_order
    guest_order.update(user_id: user.id)
    guest_order
  end

  def empty_guest_order?
    guest_order.order_items.empty?
  end

  def delete_empty_guest_order
    guest_order.destroy
    nil
  end

  def user_order_preparation
    ActiveRecord::Base.transaction do
      user_order.order_items.destroy_all
      user_order.coupon&.destroy
      user_order.destroy
    end
  end
end
