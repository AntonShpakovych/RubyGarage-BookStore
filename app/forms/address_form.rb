# frozen_string_literal: true

class AddressForm
  include ActiveModel::Model

  FIRST_LAST_NAME_FORMAT = /\A[a-zA-z]{3,50}\Z/.freeze

  attr_accessor :first_name, :last_name, :phone, :city, :country, :zip, :type, :address, :user_id

  validates :first_name, :last_name, :phone, :city, :country, :zip, :type, :address, presence: true

  validates :first_name, :last_name,
            format: { with: FIRST_LAST_NAME_FORMAT }

  def initialize(params = {})
    super(params)
  end

  def save
    if valid?
      Address.create(**all_attributes)
    else
      false
    end
  end

  def update
    if valid?
      Address.update(**all_attributes)
    else
      false
    end
  end

  private

  def all_attributes
    {
      first_name: first_name, last_name: last_name,
      phone: phone, city: city,
      country: country, zip: zip,
      type: type, address: address,
      user_id: user_id
    }
  end
end
