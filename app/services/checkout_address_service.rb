# frozen_string_literal: true

class CheckoutAddressService < CheckoutApplicationService
  attr_reader :user, :order, :params

  BILLING = :billing
  SHIPPING = :shipping

  def call
    order.to_shipping! if address_form_billing.save && address_form_shipping.save
    send_forms
  end

  private

  def address_form_billing
    @address_form_billing ||= AddressForm.new(address(BILLING), addres_params[BILLING])
  end

  def address_form_shipping
    return @address_form_shipping ||= AddressForm.new(address(SHIPPING), params_when_use_billing) if use_billing?

    @address_form_shipping ||= AddressForm.new(address(SHIPPING), addres_params[SHIPPING])
  end

  def address(type)
    Address.find_or_initialize_by(user: user, type: addres_params[type][:type])
  end

  def use_billing?
    params[:address][:use_billing] == 'true'
  end

  def addres_params
    params.require(:address).permit(:use_billing,
                                    BILLING => %i[first_name last_name address city country zip phone type],
                                    SHIPPING => %i[first_name last_name address city country zip phone type])
  end

  def params_when_use_billing
    params_for_shipping = addres_params[BILLING]
    params_for_shipping[:type] = ShippingAddress.name
    params_for_shipping
  end

  def send_forms
    { billing: address_form_billing, shipping: address_form_shipping }
  end
end
