# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def update
    @user_form = UserForm.new(User.find(current_user.id), users_params)
    @user_form.save ? good_update : bad_update
  end

  def destroy
    User.delete(current_user)
    flash[:notice] = t('privacy.destroy')
    redirect_to root_path
  end

  private

  def good_update
    flash[:notice] = t('privacy.good_update', attribute: users_params[:type])
    redirect_to root_path
  end

  def bad_update
    flash[:alert] = t('privacy.bad_update')
    render :edit
  end

  def users_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation, :type)
  end
end
