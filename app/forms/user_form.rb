# frozen_string_literal: true

class UserForm
  include ActiveModel::Model
  attr_accessor :email, :current_password, :password, :password_confirmation, :type

  EMAIL_MINIMUM_LENGTH = 3
  EMAIL_MAXIMUM_LENGTH = 63

  PASSWORD_MINIMUM_LENGTH = 8
  PASSWORD_MAXIMUM_LENGTH = 100

  EMAIL = /\A([\w+].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\Z/.freeze
  PASSWORD = /\A^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])\S+$\Z/.freeze

  validates :email, length: { minimum: EMAIL_MINIMUM_LENGTH, maximum: EMAIL_MAXIMUM_LENGTH },
                    format: { with: EMAIL, message: I18n.t('privacy.validation.email') }, if: :params_email?
  validates :current_password, :password, :password_confirmation, presence: true, if: :params_password?

  validates :password, length: { minimum: PASSWORD_MINIMUM_LENGTH, maximum: PASSWORD_MAXIMUM_LENGTH },
                       format: { with: PASSWORD, message: I18n.t('privacy.validation.password') },
                       if: :params_password? && :password_attributes_not_blank

  validate :password_validation, if: :params_password? && :password_attributes_not_blank

  def initialize(model, params = {})
    self.attributes = params
    @params = params
    @model = model
  end

  def save
    return unless valid?

    @params[:email].present? ? @model.update(email: @params[:email]) : @model.update(password: @params[:password])
    @model
  end

  private

  def params_email?
    @params[:type] == I18n.t('privacy.type.email')
  end

  def params_password?
    @params[:type] == I18n.t('privacy.type.password')
  end

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
