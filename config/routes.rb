Rails.application.routes.draw do
  resources :users, only: [:index] do
    scope module: :users do
      resources :goods, only: [:create]
    end
  end
end
