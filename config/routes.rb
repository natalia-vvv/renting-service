# frozen_string_literal: true

Rails.application.routes.draw do
  root 'items#index'
  resources :items
  get 'my_items' => 'items#my_items'
  get 'users_items' => 'items#users_items'

end
