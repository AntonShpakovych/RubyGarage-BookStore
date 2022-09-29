# frozen_string_literal: true

class AddressesController < ApplicationController
  def edit; end

  def create
    if address_form_with_choosed_type.save
      determine_redirecting(:create)
    else
      flash[:alert] = t('address.failure')
      render :edit
    end
  end

  def update
    if address_form_with_choosed_type.save
      determine_redirecting(:update)
    else
      flash[:alert] = t('address.failure')
      render :edit
    end
  end

  private

  def determine_redirecting(method)
    notice_type = "address.#{method}"
    redirect_to edit_address_path, notice: t(notice_type, address_type: addresses_params[:type])
  end

  def address_form_with_choosed_type
    if billing_type?
      @address_form_billing = address_form
    else
      @address_form_shipping = address_form
    end
  end

  def billing_type?
    addresses_params[:type] == BillingAddress.name
  end

  def address_form
    @address_form ||= AddressForm.new(address, addresses_params)
  end

  def address
    @address ||= Address.find_or_initialize_by(user: current_user, type: addresses_params[:type])
  end

  def addresses_params
    params.require(:address).permit(:first_name, :last_name, :city, :country, :zip, :phone, :address, :type)
  end
end
