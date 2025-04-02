Rails.application.routes.draw do
  resource :session
  # Para recuperar contraseña con token
  resources :passwords, param: :token, only: [ :new, :create, :edit, :update ]

  # Para cambiar la contraseña estando autenticado (sin token)
  resource :password, only: [ :edit, :update ], controller: "passwords"
  root "notes#index"
  resources :notes
  resources :users, only: [ :new, :create, :show, :destroy, :edit, :update ]
end
