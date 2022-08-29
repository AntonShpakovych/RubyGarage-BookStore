# frozen_string_literal: true

class AddressesController < ApplicationController
  def create
    if Address.create(user_id: current_user.id, **addresses_params)
      flash[:notice] = t('address.create', address_type: addresses_params[:type])
      redirect_to root_path
    else
      flash[:alert] = t('address.failure')
    end
  end

  def update
    address = Address.find_by(user_id: current_user, type: addresses_params[:type])
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
