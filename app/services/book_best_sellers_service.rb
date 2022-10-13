# frozen_string_literal: true

class BookBestSellersService
  BEST_SELLERS_COUNT = 4

  def self.call
    new.call
  end

  def call
    best_sellers
  end

  private

  def order_paid
    Order.where.not(status: %i[unprocessed canceled]).map(&:id)
  end

  def order_items
    OrderItem.where(order_id: order_paid)
  end

  def books_id
    order_items.group(:book_id).sum(:quantity)
  end

  def books_id_sort
    books_id.sort_by { |_book_id, quantity| -quantity }.map(&:first)
  end

  def best_sellers
    Book.includes([:category]).where(id: books_id_sort).reverse.uniq(&:category).first(BEST_SELLERS_COUNT)
  end
end
