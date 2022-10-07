# frozen_string_literal: true

class OrderMergeService
  attr_reader :user
  attr_accessor :user_order, :guess_order, :cookies

  def initialize(user:, guess_order:, cookies:, user_order:)
    @user = user
    @user_order = user_order
    @guess_order = guess_order
    @cookies = cookies
  end

  def call
    return unless user && cookies[:order_id]

    cookies.delete(:order_id)
    merge
  end

  private

  def merge
    user_order ? merge_exist_user_order : guess_order_set_user
  end

  def merge_exist_user_order
    return delete_empty_guess_order if empty_guess_order

    user_order_preparation
    guess_order_set_user
  end

  def guess_order_set_user
    guess_order.update(user_id: user.id)
    guess_order
  end

  def empty_guess_order
    guess_order.order_items.empty?
  end

  def delete_empty_guess_order
    guess_order.delete
    nil
  end

  def user_order_preparation
    user_order.order_items.delete_all
    user_order.coupon&.delete
    user_order.delete
  end
end
