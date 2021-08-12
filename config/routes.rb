Rails.application.routes.draw do
  resources :users, only: [:index] do
    member do
      post :nice
    end
  end
end
