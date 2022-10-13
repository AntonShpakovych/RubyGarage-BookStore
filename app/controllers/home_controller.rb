# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @latest_books = Book.order(Constants::LatestBook::ORDER).limit(Constants::LatestBook::LIMIT).decorate
    @best_sellers = BookBestSellersService.call
  end
end
