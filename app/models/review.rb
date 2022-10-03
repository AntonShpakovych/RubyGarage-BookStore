# frozen_string_literal: true

class Review < ApplicationRecord
  enum status: { unprocessed: 0, approved: 1, rejected: 2 }

  belongs_to :book
  belongs_to :user
end
