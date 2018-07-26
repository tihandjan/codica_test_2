class BookSerializer < ActiveModel::Serializer
    attributes :id, :title, :picture
    has_many :categories
    has_many :authors 
end