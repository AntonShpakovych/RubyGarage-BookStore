# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resources :books, only: %i[index show]

  resources :categories, only: :index do
    resources :books, only: :index
  end
end
