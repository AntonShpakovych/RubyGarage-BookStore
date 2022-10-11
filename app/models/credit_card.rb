# frozen_string_literal: true

class CreditCard < ApplicationRecord
  belongs_to :order, optional: true
end
