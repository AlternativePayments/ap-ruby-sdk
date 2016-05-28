Rails.application.routes.draw do
  root to: 'home#index'

  resources :customer
  get :customers, to: 'customer#customers'

  resources :transaction
  get :transactions, to: 'transaction#transactions'

end
