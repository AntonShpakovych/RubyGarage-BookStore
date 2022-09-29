# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  SHORT_DESCRIPTION_LENGTH = 250
  DEFAULT_IMAGE_URL = 'default-book.png'

  delegate_all

  def all_authors
    authors.pluck(:name).join(', ')
  end

  def short_description
    description.truncate(SHORT_DESCRIPTION_LENGTH)
  end

  def dimensions
    I18n.t('books.show.dimensions', height: height, width: width, length: length)
  end

  def book_logo_image
    images? ? images.first.url : DEFAULT_IMAGE_URL
  end
end
