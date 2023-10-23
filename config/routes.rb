# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\config\routes.rb

Rails.application.routes.draw do
  
  devise_for :users
  
  root "home#index"

  resources :users, only: [:show]
  resources :worries, only: [:new, :create, :edit, :update]

  get 'edit_selected_worries', to: 'worries#edit_selected', as: 'edit_selected_worries'
  get 'temp_page', to: 'users#temp', as: 'temp_page'

  delete 'destroy_selected_worries', to: 'worries#destroy_selected', as: 'destroy_selected_worries'

end
