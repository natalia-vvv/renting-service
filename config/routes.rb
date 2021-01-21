Rails.application.routes.draw do
  root 'items#index'
  resources :cities do
    resources :users do
      resources :items
    end
  end
end
