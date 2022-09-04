# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :category

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :height, presence: true
  validates :width, presence: true
  validates :length, presence: true
  validates :year_of_publication, presence: true
  validates :materials, presence: true
end
