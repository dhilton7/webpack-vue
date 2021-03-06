Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' } # skip: [:sessions],
  # as :user do
  #   get 'login', to: 'devise/sessions#new', as: :new_user_session
  #   post 'login', to: 'devise/sessions#create', as: :user_session
  #   delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end
  root 'static#home'

  resources :users
  resources :properties
  resources :sheets do
    resources :entries, only: [:create]
  end

  resources :entry_categories, only: [:index]
end
