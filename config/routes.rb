Rails.application.routes.draw do
  get 'guest_orders/update'
  get 'orders/update'
  get 'guest_order_items/create'
  get 'guest_order_items/update'
  get 'guest_order_items/destroy'
  get 'order_items/create'
  get 'order_items/update'
  get 'order_items/destroy'
  get 'carts/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", 
                                       :registrations => "users/registrations",
                                       :sessions => "users/sessions" }
  devise_scope :user do
    get '/guest_identify' => 'users/registrations#identify', :as => :identify
    post '/quick_registration' => 'users/registrations#quick_registration', :as => :quick_registration
  end

  match '/users/settings', to: 'users#settings', via: :get
  match '/users/update', to: 'users#update', via: :patch
  match '/users/update_password', to: 'users#update_password', via: :patch
  match '/users/destroy', to: 'users#destroy', via: :delete
  match '/users/billing_country_change', to: 'users#billing_country_change', via: :get
  match '/users/shipping_country_change', to: 'users#shipping_country_change', via: :get

  match '/billing_addresses/update/:id', to: 'billing_addresses#update', via: :patch
  match '/billing_addresses/create', to: 'billing_addresses#create', via: :post

  match '/shipping_addresses/update/:id', to: 'shipping_addresses#update', via: :patch
  match '/shipping_addresses/create', to: 'shipping_addresses#create', via: :post

  match '/checkout_addresses', to: 'checkout_addresses#index', via: :get
  match '/checkout_addresses/order_billing_country_change', to: 'checkout_addresses#billing_country_change', via: :get
  match '/checkout_addresses/order_shipping_country_change', to: 'checkout_addresses#shipping_country_change', via: :get

  match '/order_addresses/update/:id', to: 'order_addresses#update', via: :patch
  match '/order_addresses/create', to: 'order_addresses#create', via: :post

  match '/checkout_deliveries', to: 'checkout_deliveries#index', via: :get
  match '/checkout_deliveries/update', to: 'checkout_deliveries#update', via: :post

  match '/checkout_payments', to: 'checkout_payments#index', via: :get

  match '/payment_cards/update/:id', to: 'payment_cards#update', via: :patch
  match '/payment_cards/create', to: 'payment_cards#create', via: :post

  match '/checkout_confirms', to: 'checkout_confirms#index', via: :get
  match '/checkout_confirms/edit_address', to: 'checkout_confirms#edit_address', via: :get
  match '/checkout_confirms/edit_delivery', to: 'checkout_confirms#edit_delivery', via: :get
  match '/checkout_confirms/edit_payment', to: 'checkout_confirms#edit_payment', via: :get

  match '/orders/place_order', to: 'orders#place_order', via: :get

  match '/checkout_completes/:id', to: 'checkout_completes#index', via: :get

  match '/orders', to: 'orders#index', via: :get
  match '/order/:id', to: 'orders#show', via: :get

  resources :books, only: [:index, :show] do
    resources :reviews, only: [:index, :create]
  end

  root 'home#index'
  match '/admin/reviews/approve/:id', to: 'admin/reviews#approve', via: :get
  match '/admin/reviews/reject/:id', to: 'admin/reviews#reject', via: :get

  resource :cart, only: [:show]
  
  resources :order_items, only: [:create, :update, :destroy]
  resources :guest_order_items, only: [:create, :update, :destroy]
  
  match '/order_items/decrement/:id', to: 'order_items#decrement', via: :patch
  match '/order_items/increment/:id', to: 'order_items#increment', via: :patch

  match '/guest_order_items/decrement/:id', to: 'guest_order_items#decrement', via: :patch
  match '/guest_order_items/increment/:id', to: 'guest_order_items#increment', via: :patch

  match '/orders/:id', to: 'orders#update', via: :patch
  match '/guest_orders/:id', to: 'guest_orders#update', via: :patch

end