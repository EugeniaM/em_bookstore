Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :books, only: [:index, :show] do
    resources :reviews, only: [:index, :create]
  end
  root 'home#index'
  # post '/reviews/rating/:id', to: 'reviews#rate'
  # get '/books/:id/increment', to: 'books#increment'
  # get '/books/:id/decrement', to: 'books#decrement'
  match '/admin/reviews/approve/:id', to: 'admin/reviews#approve', via: :get
  match '/admin/reviews/reject/:id', to: 'admin/reviews#reject', via: :get
end