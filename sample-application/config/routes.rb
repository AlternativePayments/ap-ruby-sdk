Rails.application.routes.draw do
  root to: 'home#index'

  resources :customer
  get :customers, to: 'customer#customers'

  resources :transaction
  get :transactions, to: 'transaction#transactions'

  resources :void
  get :voids, to: 'void#voids'

  resources :refund
  get :refunds, to: 'refund#refunds'

  resources :plan
  get :plans, to: 'plan#plans'

  resources :subscription
  get :subscriptions, to: 'subscription#subscriptions'
end
