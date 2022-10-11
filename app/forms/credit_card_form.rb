# frozen_string_literal: true

class CreditCardForm < ApplicationForm
  attr_accessor :number, :date, :cvv, :name, :order_id

  CARD_NUMBER_LENGTH = 16
  NAME_MAX_LENGTH = 50
  NAME_REGEX = /\A[a-zA-Z\s]+\Z/.freeze
  CVV_DEFAULT_LENGTH = 3
  CVV_AMERICAN_EXPRESS_LENGTH = 4
  DATE_REGEX = %r/\A(0[1-9]|1[0-2])\/([0-9]){2}\Z/.freeze

  validates :number, :date, :cvv, :name, presence: true
  validates :number, length: { is: CARD_NUMBER_LENGTH }, numericality: { only_integer: true }
  validates :name, length: { maximum: NAME_MAX_LENGTH },
                   format: { with: NAME_REGEX, message: I18n.t('checkouts.partials.payment.errors.card_name') }
  validates :date, format: { with: DATE_REGEX, message: I18n.t('checkouts.partials.payment.errors.card_date') }
  validate :cvv_validation

  private

  def cvv_validation
    return if cvv.length.between?(CVV_DEFAULT_LENGTH, CVV_AMERICAN_EXPRESS_LENGTH)

    errors.add(:cvv, I18n.t('checkouts.partials.payment.errors.card_cvv',
                            default_length: CVV_DEFAULT_LENGTH, american_length: CVV_AMERICAN_EXPRESS_LENGTH))
  end
end
