# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @filters = BookQueries::FILTER_KEYS
    @book_count = Book.count
    @pagy, books = pagy(books_prepared)
    @books = books.decorate
    @current_category = current_category
    @current_filter = current_filter
  end

  def show
    @book = Book.find(params[:id]).decorate
  end

  private

  def books_prepared
    initialize_book_queries.call
  end

  def current_filter
    initialize_book_queries.filter
  end

  def current_category
    initialize_book_queries.category
  end

  def initialize_book_queries
    BookQueries.new(@books_all ||= Book.all, categories, params)
  end
end
