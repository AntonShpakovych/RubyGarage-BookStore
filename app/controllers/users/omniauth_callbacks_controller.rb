# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(auth)
      sign_out_all_scopes
      flash[:notice] = t('devise.omniauth_callbacks.success', kind: 'Google')
      sign_in_and_redirect @user, event: :authentication
    end

    private

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
end
