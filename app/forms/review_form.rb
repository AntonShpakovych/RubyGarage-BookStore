# frozen_string_literal: true

class ReviewForm < ApplicationForm
  MIN_RATING = 1
  MAX_RATING = 5
  RATING_RANGE = (MIN_RATING..MAX_RATING).freeze

  REGEX_FOR_TITLE_AND_TEXT = /\A[a-zA-Z0-9\s.]+\Z/.freeze

  MAX_LENGTH_TITLE = 80
  MAX_LENGTH_TEXT = 500

  attr_accessor :title, :text, :rating, :book_id, :user_id

  validates :title, :text, :rating, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: MIN_RATING, less_than_or_equal_to: MAX_RATING }
  validates :title, length: { maximum: MAX_LENGTH_TITLE },
                    format: { with: REGEX_FOR_TITLE_AND_TEXT,
                              message: I18n.t('books.partials.write_review.title_invalid') }
  validates :text, length: { maximum: MAX_LENGTH_TEXT },
                   format: { with: REGEX_FOR_TITLE_AND_TEXT,
                             message: I18n.t('books.partials.write_review.text_invalid') }

  def save
    return unless valid?

    @model&.save
    @model
  end
end
