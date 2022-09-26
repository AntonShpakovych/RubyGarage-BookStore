# frozen_string_literal: true

class Review < ApplicationRecord
  enum status: { unprocessed: 'Unprocessed', approved: 'Approved', rejected: 'Rejected' }

  belongs_to :book
  belongs_to :user
end
