Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login',to: 'sessions#login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#logout'
  get 'users', to: 'sessions#login'
  resources :organisations do
    resources :shifts, only:[:index]
  end
  resources :users, only:[:create,:new, :update] do
    resources :shifts, only:[:create]
  end
  root to: 'organisations#index'
end
