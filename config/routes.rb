Rails.application.routes.draw do
  devise_for :users
  # get '/users/sign_out' => 'devise/sessions#destroy'
  root to: 'boards#index'
  # get '/new', to: 'boards#new'
  resources :boards
  resource :profile, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
