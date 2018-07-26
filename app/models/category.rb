class Category < ApplicationRecord
    validates :name, presence: true
    
    has_many :categories_books, dependent: :destroy
    has_many :books, through: :categories_books
end
