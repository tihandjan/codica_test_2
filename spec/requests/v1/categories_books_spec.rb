require 'rails_helper'

RSpec.describe 'Categories Books API' do
    describe 'Categories Books' do
        let(:valid_headers)   { create(:user).create_new_auth_token }
        let(:invalid_headers) {
            headers = create(:user).create_new_auth_token
            headers['access-token'] = 'fake token'
            headers
        }
        let(:valid_params) {
            {categories_book: {
                category_id: create(:category).id,
                book_id: create(:book).id
            }}
        }
        let(:invalid_params) {
            {categories_book: {
                book_id: create(:book).id
            }}
        }

        context 'valid params & headers' do
            it 'should add category to book' do
                post '/api/v1/categories_books', params: valid_params, headers: valid_headers

                expect(response.status).to eq 201
            end

            it 'should validate uniqueness if attr' do
                post '/api/v1/categories_books', params: valid_params, headers: valid_headers
                post '/api/v1/categories_books', params: valid_params, headers: valid_headers

                expect(json['book_id']).to eq ["has already been taken"]
            end

            it 'should remove category from book' do
                cb = create(:categories_book)
                delete "/api/v1/categories_books/#{cb.id}", headers: valid_headers

                expect(response.status).to eq 200
            end
        end

        context 'invalid params & headers' do
            it 'should not add category to book' do
                post '/api/v1/categories_books', params: invalid_params, headers: valid_headers

                expect(response.status).to eq 422
                expect(json['category']).to eq ["must exist"]
            end

            it 'should not add category to book' do
                expect{
                    post '/api/v1/categories_books', params: valid_params, headers: invalid_params
                }.to raise_error(ApplicationController::PermissionDeniedError, 'Permission denied')
            end

            it 'should not remove category from book' do
                cb = create(:categories_book)

                expect{
                    delete "/api/v1/categories_books/#{cb.id}", headers: invalid_headers
                }.to raise_error(ApplicationController::PermissionDeniedError, 'Permission denied')
            end
        end
    end
end