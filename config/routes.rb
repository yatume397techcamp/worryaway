# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\config\routes.rb

Rails.application.routes.draw do
  
  devise_for :users
  
  root "home#index"

  resources :users, only: [:show]
  resources :worries, only: [:new, :create]

end
