# frozen_string_literal: true

class AuthorsBook < ApplicationRecord
  belongs_to :author
  belongs_to :book
end
