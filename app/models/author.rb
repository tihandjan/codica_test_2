class Author < ApplicationRecord
    validates :name, presence: true
    
    has_many :authors_books, dependent: :destroy
    has_many :books, through: :authors_books
end
