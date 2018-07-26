require 'rails_helper'

RSpec.describe 'Authors Books API' do
    describe 'Authors Books' do
        let(:valid_headers)   { create(:user).create_new_auth_token }
        let(:invalid_headers) {
            headers = create(:user).create_new_auth_token
            headers['access-token'] = 'fake token'
            headers
        }
        let(:valid_params) {
            {authors_book: {
                author_id: create(:author).id,
                book_id: create(:book).id
            }}
        }
        let(:invalid_params) {
            {authors_book: {
                author_id: create(:author).id
            }}
        }

        context 'valid params & headers' do
            it 'should add author to book' do
                post '/api/v1/authors_books', params: valid_params, headers: valid_headers

                expect(response.status).to eq 201
            end

            it 'should validate uniqueness if attr' do
                post '/api/v1/authors_books', params: valid_params, headers: valid_headers
                post '/api/v1/authors_books', params: valid_params, headers: valid_headers

                expect(json['book_id']).to eq ["has already been taken"]
            end

            it 'should remove author from book' do
                ab = create(:authors_book)
                delete "/api/v1/authors_books/#{ab.id}", headers: valid_headers

                expect(response.status).to eq 200
            end
        end

        context 'invalid params & headers' do
            it 'should not add author to book' do
                post '/api/v1/authors_books', params: invalid_params, headers: valid_headers

                expect(response.status).to eq 422
                expect(json['book']).to eq ["must exist"]
            end

            it 'should not add author to book' do
                expect{
                    post '/api/v1/authors_books', params: valid_params, headers: invalid_params
                }.to raise_error(ApplicationController::PermissionDeniedError, 'Permission denied')
            end

            it 'should not remove author from book' do
                ab = create(:authors_book)

                expect{
                    delete "/api/v1/authors_books/#{ab.id}", headers: invalid_headers
                }.to raise_error(ApplicationController::PermissionDeniedError, 'Permission denied')
            end
        end
    end
end