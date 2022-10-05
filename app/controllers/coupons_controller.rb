# frozen_string_literal: true

class CouponsController < ApplicationController
  def update
    return redirect_with_flash(alert: 'Bad code') if find_coupon.nil?

    if coupon_form.save
      redirect_with_flash(notice: t('carts.message.valid_coupon'))
    else
      redirect_with_flash(alert: t('carts.message.invalid_coupon'))
    end
  end

  private

  def coupon_form
    @coupon_form ||= CouponForm.new(find_coupon, permitted_params)
  end

  def redirect_with_flash(notice: nil, alert: nil)
    return redirect_to cart_path, notice: notice if notice

    redirect_to cart_path, alert: alert
  end

  def find_coupon
    @find_coupon ||= Coupon.find_by(code: permitted_params[:code])
  end

  def permitted_params
    params.require(:coupon).permit(:code).merge(order_id: @current_order.id)
  end
end
