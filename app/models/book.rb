class Book < ApplicationRecord
  belongs_to :category

  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  validates :name, presence: true
end
