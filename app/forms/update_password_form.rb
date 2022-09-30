# frozen_string_literal: true

class UpdatePasswordForm < ApplicationForm
  attr_accessor :current_password, :password, :password_confirmation

  PASSWORD_MINIMUM_LENGTH = 8
  PASSWORD_MAXIMUM_LENGTH = 100

  PASSWORD = /\A^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])\S+$\Z/.freeze

  validates :current_password, :password, :password_confirmation, presence: true

  validates :password, length: { minimum: PASSWORD_MINIMUM_LENGTH, maximum: PASSWORD_MAXIMUM_LENGTH },
                       format: { with: PASSWORD, message: I18n.t('privacy.validation.password') },
                       if: :password_attributes_not_blank

  validate :password_validation,  if: :password_attributes_not_blank

  def save
    return unless valid?

    @model.update(password: @params[:password])
    @model
  end

  private

  def password_validation
    password_old_validate
    password_confirmation_validate
  end

  def password_old_validate
    return if @model.valid_password?(current_password)

    errors.add(:current_password, I18n.t('privacy.validation.password_old'))
  end

  def password_confirmation_validate
    return if password == password_confirmation

    errors.add(:password_confirmation, I18n.t('privacy.validation.password_confirmation'))
  end

  def password_attributes_not_blank
    current_password.present? && password.present? && password_confirmation.present?
  end
end
