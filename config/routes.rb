Rails.application.routes.draw do
  root "home#index"

  match "/auth/:provider" => "omniauth_callbacks#passthru", via: [:get, :post], as: :omniauth
  match "/auth/:provider/callback" => "omniauth_callbacks#callback", via: [:get, :post]
  get "sign_out" => "omniauth_callbacks#sign_out", as: :sign_out
end
