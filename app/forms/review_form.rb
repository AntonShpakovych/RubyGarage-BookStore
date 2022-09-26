# frozen_string_literal: true

class ReviewForm
  include ActiveModel::Model

  MIN_RATING = 1
  MAX_RATING = 5
  RATING_RANGE = (MIN_RATING..MAX_RATING).freeze

  REGEX_FOR_TITLE_AND_TEXT = /\A([a-zA-Z0-9\s]+.{1})\Z/.freeze

  MIN_LENGTH_TITLE = 20
  MAX_LENGTH_TITLE = 80

  MIN_LENGTH_TEXT = 70
  MAX_LENGTH_TEXT = 500

  attr_accessor :title, :text, :rating, :book_id, :user_id

  validates :title, :text, :rating, presence: true
  validates :title, length: { minimum: MIN_LENGTH_TITLE, maximum: MAX_LENGTH_TITLE },
                    format: { with: REGEX_FOR_TITLE_AND_TEXT,
                              message: I18n.t('books.partials.write_review.title_invalid') }
  validates :text, length: { minimum: MIN_LENGTH_TEXT, maximum: MAX_LENGTH_TEXT },
                   format: { with: REGEX_FOR_TITLE_AND_TEXT,
                             message: I18n.t('books.partials.write_review.text_invalid') }

  def initialize(model, params = {})
    self.attributes = params
    @params = params
    @model = model
  end

  def save
    return unless valid?

    @model&.save
    @model
  end
end
