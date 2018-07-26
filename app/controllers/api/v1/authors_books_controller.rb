class Api::V1::AuthorsBooksController < ApplicationController
    before_action :check_permission, only: [:create, :destroy]
    before_action :set_ab, only: [:destroy]

    def create
        authors_book = AuthorsBook.new authors_book_params
        if authors_book.save
            render json: authors_book, status: :created
        else
            render json: authors_book.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @ab.destroy        
            render json: @ab, status: 200
        end
    end
    private

    def authors_book_params
        params.require(:authors_book).permit(:author_id, :book_id)        
    end

    def check_permission
        raise PermissionDeniedError.new('Permission denied') unless user_signed_in?
    end

    def set_ab
        @ab = AuthorsBook.find params[:id]        
    end
end