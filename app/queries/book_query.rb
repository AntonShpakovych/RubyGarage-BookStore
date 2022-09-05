# frozen_string_literal: true

class BookQuery
  FILTER_KEYS = {
    :name_asc => 'name ASC',
    :name_desc => 'name DESC',
    :newest_first => 'created_at ASC',
    :price_hight_to_low => 'price DESC',
    :price_low_to_hight => 'price ASC'
  }.freeze

  DEFAULT_FILTER_KEY = :name_asc

  attr_reader :category, :filter

  def initialize(params)
    @books = Book.all
    @filter = genarate_filter(params[:filter])
    @category = params[:category_id]
  end

  def call
    sorting_and_filtering_books
  end

  private

  def sorting_and_filtering_books
    books_sort_by_category
    @books.order(FILTER_KEYS[filter])
  end

  def books_sort_by_category
    @books_sort_by_category ||= @books = category.present? ? @books.where(category_id: category) : @books
  end

  def genarate_filter(filter)
    FILTER_KEYS.key?(filter&.to_sym) ? filter.to_sym : DEFAULT_FILTER_KEY
  end
end
