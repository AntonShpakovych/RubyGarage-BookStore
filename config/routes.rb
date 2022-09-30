# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  resource :user, only: %i[edit destroy]
  resource :address, only: %i[edit update create]
  resources :books, only: %i[index show]
  resources :categories, only: :index do
    resources :books, only: :index
  end

  resource :update_email, only: %i[update]
  resource :update_password, only: %i[update]

  get 'address', to: redirect('/address/edit')
  get 'update_email', to: redirect('/user/edit')
  get 'update_password', to: redirect('/user/edit')
  get 'user', to: redirect('/user/edit')
end
