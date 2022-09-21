# frozen_string_literal: true

class User < ApplicationRecord
  START_PASSWORD_LENGTH = 0
  END_PASSWORD_LENGTH = 20

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[START_PASSWORD_LENGTH, END_PASSWORD_LENGTH]
    end
  end
end
