# frozen_string_literal: true

class BookQueries
  FILTER_KEYS = {
    'name_asc' => 'name ASC',
    'name_desc' => 'name DESC',
    'newest_first' => 'created_at ASC',
    'price_hight_to_low' => { price: :desc },
    'price_low_to_hight' => :price
  }.freeze

  DEFAULT_CATEGORY = I18n.t('books.partials.desktop.category.category_all')
  DEFAULT_FILTER = FILTER_KEYS.keys.first

  attr_reader :category, :filter

  def initialize(books, categories, params)
    @books = books
    @filter = params[:filter].nil? ? DEFAULT_FILTER : params[:filter]
    @category = category_invalid?(params) ? DEFAULT_CATEGORY : categories.find(params[:category])
  end

  def call
    by_category
    by_filter
    @books
  end

  private

  def category_invalid?(params)
    params[:category].nil? || params[:category] == DEFAULT_CATEGORY
  end

  def by_category
    @books = category == DEFAULT_CATEGORY ? @books : @books.where(category: category)
  end

  def by_filter
    @books = @books.order(FILTER_KEYS[filter])
  end
end
