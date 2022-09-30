# frozen_string_literal: true

class UpdateEmailForm < ApplicationForm
  attr_accessor :email

  EMAIL_MINIMUM_LENGTH = 3
  EMAIL_MAXIMUM_LENGTH = 63

  EMAIL = /\A([\w+].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\Z/.freeze

  validates :email, presence: true

  validates :email, length: { minimum: EMAIL_MINIMUM_LENGTH, maximum: EMAIL_MAXIMUM_LENGTH },
                    format: { with: EMAIL, message: I18n.t('privacy.validation.email') }
end
