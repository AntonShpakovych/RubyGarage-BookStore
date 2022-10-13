# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations' }
  root 'home#index'

  resource :user, only: %i[edit destroy]
  resource :address, only: %i[edit update create]

  resources :books, only: %i[index show] do
    resource :review, only: %i[create]
  end

  resources :categories, only: :index do
    resources :books, only: :index
  end

  resources :orders, only: %i[index show]
  resources :order_items, only: %i[create destroy update]
  resource :cart, only: %i[show]
  resource :coupon, only: %i[update]

  resource :update_email, only: %i[update]
  resource :update_password, only: %i[update]

  resource :checkout, only: %i[show update]

  get 'address', to: redirect('/address/edit')
  get 'update_email', to: redirect('/user/edit')
  get 'update_password', to: redirect('/user/edit')
  get 'user', to: redirect('/user/edit')
end
