# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\config\routes.rb

Rails.application.routes.draw do
  
  devise_for :users
  
  root "home#index"

  resources :users, only: [:show]
  resources :worries, only: [:new, :create, :edit, :update]

  get 'edit_selected_worries', to: 'worries#edit_selected', as: 'edit_selected_worries'
  get 'temp_page', to: 'users#temp', as: 'temp_page'

  post 'move_to_main_worries', to: 'worries#move_to_main', as: 'move_to_main_worries'
  post 'move_to_temp_worries', to: 'worries#move_to_temp', as: 'move_to_temp_worries'


end
