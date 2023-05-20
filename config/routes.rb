Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
    }
  get '/users/:id', to: 'users#show', as: 'user'
  # get '/users/sign_out' => 'devise/sessions#destroy'
  root to: 'boards#index'
  # get '/new', to: 'boards#new'
  resources :boards
  resource :profile, only: [:show, :edit, :update]
  post '/profile/edit', to: 'profiles#update'
  # get '/profile/edit' => 'profiles#edit'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
