# frozen_string_literal: true

class BooksController < ApplicationController
  REVIEW_DEFAULT_SORTING = 'created_at DESC'

  def index
    @book_count = Book.count
    @pagy, books = pagy(books_prepared)
    @books = books.includes(:authors).decorate
    @current_category = book_query_category
    @current_filter = book_query_filter
  end

  def show
    @book = Book.find(params[:id]).decorate
    @reviews = @book.reviews.includes(:user).approved.order(REVIEW_DEFAULT_SORTING)
  end

  private

  def books_prepared
    @books_prepared ||= book_query.call
  end

  def book_query_filter
    @book_query_filter ||= book_query.filter
  end

  def book_query_category
    @book_query_category ||= book_query.category
  end

  def book_query
    @book_query ||= BookQuery.new(params)
  end
end
