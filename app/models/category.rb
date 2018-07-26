class Category < ApplicationRecord
    validates :name, presence: true
    
    has_many :categories_books
    has_many :books, through: :categories_books
end
