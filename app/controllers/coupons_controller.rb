# frozen_string_literal: true

class CouponsController < ApplicationController
  before_action :undefined_coupon, unless: :coupon

  def update
    if coupon_form.save
      redirect_with_flash(notice: t('carts.message.valid_coupon'))
    else
      redirect_with_flash(alert: coupon_form.errors[:order_id].to_sentence)
    end
  end

  private

  def coupon_form
    @coupon_form ||= CouponForm.new(coupon, { order_id: permitted_params[:order_id] })
  end

  def redirect_with_flash(notice: nil, alert: nil)
    flash_options =  { notice: notice, alert: alert }.compact_blank
    redirect_to cart_path, **flash_options
  end

  def coupon
    @coupon ||= Coupon.find_by(code: permitted_params[:code])
  end

  def undefined_coupon
    redirect_with_flash(alert: t('carts.message.coupon_undefined'))
  end

  def permitted_params
    params.require(:coupon).permit(:code).merge(order_id: current_order.id)
  end
end
