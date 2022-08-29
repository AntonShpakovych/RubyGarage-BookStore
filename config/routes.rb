# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers:{ omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  root 'home#index'
  resources :addresses
  resources :books, only: %i[index show]
end
