# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(
        :email,
        :password,
        :password_confirmation,
        :current_password
      )
    end
  end

  def update_resource(resource, params)
    return super if params['password']&.present?

    resource.update_without_password(email: params[:email])
  end
end
