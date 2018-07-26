class Book < ApplicationRecord
    validates :title, presence: true
    validates :picture, presence: true

    has_many :authors_books, dependent: :destroy
    has_many :categories_books, dependent: :destroy
    has_many :authors, through: :authors_books
    has_many :categories, through: :categories_books

    mount_base64_uploader :picture, PictureUploader
end
