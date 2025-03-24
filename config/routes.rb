Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "notes#index"
  resources :notes
  resources :users, only: [ :new, :create ]
end
