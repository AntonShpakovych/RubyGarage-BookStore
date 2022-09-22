# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: t('privacy.destroy')
  end
end
