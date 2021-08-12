Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    member do
      post :nice
    end
  end
  resources :admin, only: [:index]
  root 'home#index'
end
