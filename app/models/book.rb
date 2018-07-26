class Book < ApplicationRecord
    validates :title, presence: true

    has_many :authors_books
    has_many :categories_books
    has_many :authors, through: :authors_books
    has_many :categories, through: :categories_books
end
