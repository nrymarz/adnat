Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login',to: 'sessions#login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#logout'
  get 'users', to: 'sessions#login'
  resources :organisations, only: [:index,:edit,:update,:create] do
    resources :shifts, only:[:index]
  end
  patch '/users/update_org', to: 'users#update_org'
  resources :users, only:[:create,:new, :update, :edit] do
    resources :shifts, only:[:create,:update,:destroy,:edit]
  end
  root to: 'organisations#index'

  get 'password/reset', to: "passwordresets#new"
  post "password/reset", to: "passwordresets#create"
  get 'password/reset/edit', to: "passwordresets#edit"
  patch "password/reset", to: "passwordresets#update"

end
