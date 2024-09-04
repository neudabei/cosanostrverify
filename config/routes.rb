Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "users#new"
  resources :users, only: [:create]

  get '/.well-known/nostr.json', to: 'verification#serve_json', as: :nostr_json
end
