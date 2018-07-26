Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :books, only: [:create, :index]
      resources :authors, only: [:create, :index]
      resources :categories, only: [:create, :index]
      resources :authors_books, only: [:create, :destroy]
      resources :categories_books, only: [:create, :destroy]
    end
  end
end
