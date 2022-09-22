# frozen_string_literal: true

class AddressForm
  include ActiveModel::Model

  FIRST_NAME_MIN_LENGTH = 3
  FIRST_NAME_MAX_LENGTH = 50

  LAST_NAME_MIN_LENGTH = 3
  LAST_NAME_MAX_LENGTH = 50

  ADDRESS_MIN_LENGTH = 3
  ADDRESS_MAX_LENGTH = 50

  COUNTRY_MIN_LENGTH = 2
  COUNTRY_MAX_LENGTH = 50

  CITY_MIN_LENGTH = 3
  CITY_MAX_LENGTH = 50

  ZIP_MIN_LENGTH = 5
  ZIP_MAX_LENGTH = 10

  PHONE_MIN_LENGTH = 10
  PHONE_MAX_LENGTH = 15

  FIRST_NAME = /\A[a-zA-z]+\Z/.freeze
  LAST_NAME = /\A[a-zA-z]+\Z/.freeze
  ADDRESS = /\A[a-zA-Z0-9\-,\s]+\Z/.freeze
  COUNTRY = /\A[a-zA-z]+\Z/.freeze
  CITY = /\A[a-zA-z]+\Z/.freeze
  ZIP = /\A[0-9-]+\Z/.freeze
  PHONE = /\A\+[0-9]+\Z/.freeze

  attr_accessor :first_name, :last_name, :phone, :city, :country, :zip, :type, :address

  validates :first_name, :last_name, :phone, :city, :country, :zip, :address, presence: true

  validates :first_name, length: { minimum: FIRST_NAME_MIN_LENGTH, maximum: FIRST_NAME_MAX_LENGTH },
                         format: { with: FIRST_NAME, message: I18n.t('address.validation.first_name') }
  validates :last_name, length: { minimum: LAST_NAME_MIN_LENGTH, maximum: LAST_NAME_MAX_LENGTH },
                        format: { with: LAST_NAME, message: I18n.t('address.validation.last_name') }
  validates :address, length: { minimum: ADDRESS_MIN_LENGTH, maximum: ADDRESS_MAX_LENGTH },
                      format: { with: ADDRESS, message: I18n.t('address.validation.address') }
  validates :country, length: { minimum: COUNTRY_MIN_LENGTH, maximum: COUNTRY_MAX_LENGTH },
                      format: { with: COUNTRY, message: I18n.t('address.validation.country') }
  validates :city, length: { minimum: CITY_MIN_LENGTH, maximum: CITY_MAX_LENGTH },
                   format: { with: CITY, message: I18n.t('address.validation.city') }
  validates :zip, length: { minimum: ZIP_MIN_LENGTH, maximum: ZIP_MAX_LENGTH },
                  format: { with: ZIP, message: I18n.t('address.validation.zip') }
  validates :phone, length: { minimum: PHONE_MIN_LENGTH, maximum: PHONE_MAX_LENGTH },
                    format: { with: PHONE, message: I18n.t('address.validation.phone') }

  validate :validate_phone

  def initialize(model, params = {})
    self.attributes = params
    @params = params
    @model = model
  end

  def save
    return unless valid?

    @model ? @model.update(@params) : @model.save
    @model
  end

  private

  def validate_phone
    return errors.add(:county, I18n.t('address.validation.country')) if country.blank?
    return if phone.include?(selected_country.country_code)

    errors.add(:phone, I18n.t('address.validation.phone'))
  end

  def selected_country
    ISO3166::Country(@params[:country])
  end
end
