# frozen_string_literal: true

class Book < ApplicationRecord
  MIN_PRICE_VALUE = 0

  belongs_to :category

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  validates :name, :price, :description, :quantity, :height, :width,
            :length, :year_of_publication, :materials, presence: true
  validates :price, numericality: { greater_than: MIN_PRICE_VALUE }
end
