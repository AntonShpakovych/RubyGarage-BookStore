# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      quick_registration? ? quick_registrate : super
    end

    private

    def quick_registrate
      params[:user][:password] = params[:user][:password_confirmation] = devise_password
      build_resource(sign_up_params)
      resource.save ? authenticate_user : redirect_back_and_show_errors
    end

    def authenticate_user
      sign_up(resource_name, resource)
      resource.send_reset_password_instructions
      redirect_to(checkout_path, notice: t('devise.quick_registration.message.password_instructions'))
    end

    def devise_password
      Devise.friendly_token[User::START_PASSWORD_LENGTH, User::END_PASSWORD_LENGTH]
    end

    def quick_registration?
      params[:user][:quick].present?
    end

    def redirect_back_and_show_errors
      redirect_to cart_path, alert: resource.errors.full_messages.to_sentence
    end
  end
end
