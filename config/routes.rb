Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'account#index'

  resources :transactions, only: [:create]
  get '/transactions/deposit', to: 'transactions#deposit', as: :new_deposit
  post '/transactions/deposit', to: 'transactions#create', as: :transactions_deposit
  get '/transactions/transfer', to: 'transactions#transfer', as: :new_transfer
  post '/transactions/transfer', to: 'transactions#transfer', as: :transactions_transfer
  get '/transactions/withdraw', to: 'transactions#withdraw', as: :new_withdraw
  post '/transactions/withdraw', to: 'transactions#withdraw', as: :transactions_withdraw

  devise_for :users
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
