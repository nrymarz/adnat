Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login',to: 'sessions#login'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#logout'
  resources :organisations
  resources :users, only:[:create,:show,:new]
  root to: 'organisations#index'
end
