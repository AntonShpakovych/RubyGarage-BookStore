# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers:{
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'home#index'
  resources :books, only: %i[index show]
  resources :users, only: %i[edit update]
end
