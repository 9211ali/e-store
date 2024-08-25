Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  authenticated :admin_user do
    root "admin#index", as: :admin_root
  end
  get "admin", to: "admin#index"

  # admin routes
  devise_for :admins
  namespace :admin do
    resources :categories
    resources :orders
    resources :products do
      resources :stocks
    end
  end

  # user routes
  resources :categories, only: [:show]
  resources :products, only: [:show]
  get "cart", to: "carts#show"
  post "checkout", to: "checkouts#create"
  get "success", to: "checkouts#success"
  get "cancel", to: "checkouts#cancel"
  post 'webhooks', to: 'webhooks#stripe'
end
