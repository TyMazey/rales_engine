Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: 'revenue#index'
        get 'revenue', to: 'revenue_date#show'
        get 'most_items', to: 'items#index'
        get ':id/items', to: 'items#show'
        get ':id/invoices', to: 'invoices#show'
        get ':id/revenue', to: 'revenue#show'
        get ':id/favorite_customer', to: 'customers#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/transactions', to: 'transactions#show'
        get ':id/customer', to: 'customers#show'
        get ':id/merchant', to: 'merchants#show'
        get ':id/invoice_items', to: 'invoice_items#show'
        get ':id/items', to: 'items#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :invoice_items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/item', to: 'items#show'
        get ':id/invoice', to: 'invoices#show'
      end
      resources :invoice_items, only: [:index, :show]

      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'most_revenue',to: 'revenue#index'
        get 'most_items',to: 'sold#index'
        get ':id/invoice_items', to: 'invoice_items#show'
        get ':id/merchant', to: 'merchants#show'
        get ':id/best_day',to: 'revenue#show'
      end
      resources :items, only: [:index, :show]

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoice',to: 'invoices#show'
      end
      resources :transactions, only: [:index, :show]

      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/favorite_merchant', to: 'merchants#show'
        get ':id/transactions',to: 'transactions#show'
        get ':id/invoices',to: 'invoices#show'
      end
      resources :customers, only: [:index, :show]
    end
  end
end
