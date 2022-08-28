# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def update
    user = User.find(current_user.id)
    if user.update(permitted_params)
      flash[:notice] = t('users.update_good')
      redirect_to edit_user_url
    else
      flash[:alert] = t('users.update_failure')
      render :edit
    end
  end

  private

  def permitted_params
    params.require(:user).permit(
      :password,
      :current_password,
      :password_confirmation,
      :email,
      billing_attributes: %i[first_name last_name address city zip country phone],
      shipping_attributes: %i[first_name last_name address city zip country phone]
    )
  end
end
