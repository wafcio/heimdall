Rails.application.routes.draw do
  root "home#index"

  namespace :admin do
    resources :users, only: [:index, :update]
  end
  resources :categories, except: [:show]

  mount PostgresqlLoStreamer::Engine => "/category_image"

  match "/auth/:provider" => "omniauth_callbacks#passthru", via: [:get, :post], as: :omniauth
  match "/auth/:provider/callback" => "omniauth_callbacks#callback", via: [:get, :post]
  get "sign_out" => "omniauth_callbacks#sign_out", as: :sign_out
end
