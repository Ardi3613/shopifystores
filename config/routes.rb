require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :shopify_stores
    resources :users

    root to: "users#index"
  end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  get '/search_result', to: 'home#search_result'
  get '/import_form', to: 'home#import_form'
  post '/import_stores', to: 'home#import_stores'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
