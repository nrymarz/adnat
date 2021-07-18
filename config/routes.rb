Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login' to 'sessions#login'
  post 'logout' to 'sessions#logout'
  resources :users, only:[:create,:show,:new]
end
