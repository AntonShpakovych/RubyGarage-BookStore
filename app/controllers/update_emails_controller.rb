# frozen_string_literal: true

class UpdateEmailsController < ApplicationController
  def update
    @email_form = UpdateEmailForm.new(current_user, permitted_params)
    @email_form.save ? good_update : bad_update
  end

  private

  def good_update
    redirect_to user_path, notice: t('privacy.good_update', attribute: t('privacy.type.email'))
  end

  def bad_update
    flash[:alert] = t('privacy.bad_update')
    render 'users/edit'
  end

  def permitted_params
    params.require(:email).permit(:email)
  end
end
