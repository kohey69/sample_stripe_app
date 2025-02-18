Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :subscription, only: %i[create]
  post "/stripe_checkout_webhook" => "stripe_webhook#checkout"

  root "home#index"
end
