Rails.application.routes.draw do
  root "home#index"

  namespace :admin do
    resources :users, only: %i(index update)
  end
  resources :categories, except: [:show]
  resources :points
  resources :images, only: %i(create destroy)

  match "/auth/:provider" => "omniauth_callbacks#passthru", via: %i(get post), as: :omniauth
  match "/auth/:provider/callback" => "omniauth_callbacks#callback", via: %i(get post)
  get "sign_out" => "omniauth_callbacks#sign_out", as: :sign_out
end
