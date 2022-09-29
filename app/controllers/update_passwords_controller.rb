# frozen_string_literal: true

class UpdatePasswordsController < ApplicationController
  def update
    @password_form = UpdatePasswordForm.new(current_user, permitted_params)
    @password_form.save ? good_update : bad_update
  end

  private

  def good_update
    redirect_to root_path, notice: t('privacy.good_update', attribute: t('privacy.type.password'))
  end

  def bad_update
    flash[:alert] = t('privacy.bad_update')
    render 'users/edit'
  end

  def permitted_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
