require 'rails_helper'

RSpec.describe 'Books API' do
    describe 'books' do
        let(:valid_headers)   { create(:admin_user).create_new_auth_token }
        let(:invalid_headers) {
            headers = create(:user).create_new_auth_token
            headers['access-token'] = 'fake token'
            headers
        }
        let(:valid_params) {
            file = fixture_file_upload(Rails.root.join('spec', 'files', 'test.png'))
            {book: {title: 'Lorem ipsum', 
                    picture: file}}
        }
        let(:invalid_params) {
            file = fixture_file_upload(Rails.root.join('spec', 'files', 'test.png'))
            {book: {
                    title: '',
                    }}
        }
        it 'gets a list of books' do
            
            FactoryBot.create_list :book, 3
            get '/api/v1/books', {}
    
            expect(json.length).to eq(3)
        end
        context 'valid auth credantials' do
            it 'saves a new book' do
                post "/api/v1/books", params: valid_params, headers: valid_headers
    
                expect(json['title']).to eq('Lorem ipsum')
            end
        end
        context 'invalid auth credantials' do
            it 'should through an error' do
                expect{ post '/api/v1/books', params: valid_params, headers: invalid_headers }.to raise_error(ApplicationController::PermissionDeniedError, 'Permission denied')
            end
        end
        context 'invalid attr' do
            it 'should return an error object' do
                post '/api/v1/books', params: invalid_params, headers: valid_headers

                expect(json['title']).to eq(["can't be blank"])
                expect(json['picture']).to eq(["can't be blank"])
            end
        end
    end
end