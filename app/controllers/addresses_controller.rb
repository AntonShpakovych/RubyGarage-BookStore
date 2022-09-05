# frozen_string_literal: true

class AddressesController < ApplicationController
  def edit
    @address_form = AddressForm.new
  end

  def create
    @address_form = AddressForm.new(user_id: current_user.id, **addresses_params)

    flash[:notice] = t('address.create', address_type: addresses_params[:type]) if @address_form.save
    redirect_to edit_address_path(current_user.id)
  end

  def update
    address = AddressForm.update(user_id: current_user, type: addresses_params[:type])

    if address.update(addresses_params)
      flash[:notice] = t('address.update', address_type: addresses_params[:type])
      redirect_to root_path
    else
      flash[:alert] = t('address.failure')
    end
  end

  private

  def addresses_params
    params.require(:address).permit(:first_name, :last_name, :city, :country, :zip, :phone, :address, :type)
  end
end
