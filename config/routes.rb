Rails.application.routes.draw do
  root 'items#index'
  resources :cities do
    resources :users
  end
end
