Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :subscription, only: %i[create]

  root "home#index"
end
