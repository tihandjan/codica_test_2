class Api::V1::BooksController < ApplicationController
    before_action :check_permission, only: [:create]

    def index
        render json: Book.all
    end    

    def create
        book = Book.new book_params
        if book.save
            render json: book, status: :created
        else
            render json: book.errors, status: :unprocessable_entity
        end
    end
    private

    def book_params
        params.require(:book).permit(:title, :picture)        
    end

    def check_permission
        raise PermissionDeniedError.new('Permission denied') unless user_signed_in?
    end
end