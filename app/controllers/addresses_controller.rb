# frozen_string_literal: true

class AddressesController < ApplicationController
  def edit; end

  def create
    if address_form_with_choosed_type.save
      flash[:notice] = t('address.create', address_type: addresses_params[:type])
      redirect_to root_path
    else
      flash[:alert] = t('address.failure')
      render :edit
    end
  end

  def update
    if address_form_with_choosed_type.save
      flash[:notice] = t('address.update', address_type: addresses_params[:type])
      redirect_to root_path
    else
      flash[:alert] = t('address.failure')
      render :edit
    end
  end

  private

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
    AddressForm.new(address, addresses_params)
  end

  def address
    Address.find_or_initialize_by(user_id: current_user.id, type: addresses_params[:type])
  end

  def addresses_params
    params.require(:address).permit(:first_name, :last_name, :city, :country, :zip, :phone, :address, :type)
  end
end
