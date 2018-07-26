class Api::V1::CategoriesBooksController < ApplicationController
    before_action :check_permission, only: [:create, :destroy]
    before_action :set_cb, only: [:destroy]
    load_and_authorize_resource 

    def create
        categories_book = CategoriesBook.new categories_book_params
        if categories_book.save
            render json: categories_book, status: :created
        else
            render json: categories_book.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @cb.destroy        
            render json: @cb, status: 200
        end
    end
    private

    def categories_book_params
        params.require(:categories_book).permit(:category_id, :book_id)        
    end

    def check_permission
        raise PermissionDeniedError.new('Permission denied') unless user_signed_in?
    end

    def set_cb
        @cb = CategoriesBook.find params[:id]        
    end
end