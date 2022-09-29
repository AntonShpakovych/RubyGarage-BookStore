# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def destroy
    current_user.destroy if permmit_params[:check]
    redirect_to root_path, notice: t('privacy.destroy')
  end

  def permmit_params
    params.require(:user).permit(:check)
  end
end
