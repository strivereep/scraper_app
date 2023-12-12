require 'sidekiq/web'

Rails.application.routes.draw do
  root to: redirect('/categories')

  get 'categories', to: 'home#index'
  get 'categories/*', to: 'home#index'
  get 'categories/:id', to: 'home#index'
  get 'categories/:id/products/:id', to: 'home#index'
  get 'categories/:id/products/:id/edit', to: 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    resources :products, only: %i[create update destroy]
    resources :categories, only: [:index]
  end
end
