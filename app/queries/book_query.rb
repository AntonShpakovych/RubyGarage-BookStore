# frozen_string_literal: true

class BookQuery
  ORDERS_TYPE = {
    :name_asc => 'name ASC',
    :name_desc => 'name DESC',
    :newest_first => 'created_at ASC',
    :price_hight_to_low => 'price DESC',
    :price_low_to_hight => 'price ASC'
  }.freeze

  DEFAULT_FILTER_KEY = ORDERS_TYPE[:name_asc]

  attr_reader :category, :filter

  def initialize(params, books = Book.all)
    @books = books
    @filter = generate_order_by(params[:filter]&.to_sym)
    @category = params[:category_id]
  end

  def call
    sorting_and_filtering_books
  end

  private

  def sorting_and_filtering_books
    books_sort_by_category.order(filter)
  end

  def books_sort_by_category
    @books_sort_by_category ||= category.present? ? @books.where(category_id: category) : @books
  end

  def generate_order_by(filter)
    ORDERS_TYPE[filter] || DEFAULT_FILTER_KEY
  end
end
