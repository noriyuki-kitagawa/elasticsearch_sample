Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    member do
      post :nice
    end
  end
  resources :admin, only: [:index, :show]
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :admin, only: [:index]
    end
  end
  root 'home#index'
end
