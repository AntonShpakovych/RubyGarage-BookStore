# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  SHORT_DESCRIPTION_LENGTH = 250

  delegate_all

  def all_authors
    authors.map(&:name).join(',')
  end

  def short_description
    description.truncate(SHORT_DESCRIPTION_LENGTH)
  end

  def dimensions
    I18n.t('books.show.dimensions', height: height, width: width, length: length)
  end
end
