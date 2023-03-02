Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customer_subscriptions, only: [:create, :update]
      resources :customers, only: [:show] do
        resources :subscription, only: [:index]
      end
    end
  end
end
