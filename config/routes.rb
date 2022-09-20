# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  resources :users, only: %i[edit update destroy]
  resources :addresses, only: %i[edit update create]
  resources :books, only: %i[index show]

  resources :categories, only: :index do
    resources :books, only: :index
  end
  get '/addresses', to: 'addresses#edit'
  get '/addresses/:id', to: 'addresses#edit'
  get '/users/:id', to: 'users#edit'
end
