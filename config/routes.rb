Rails.application.routes.draw do
  get 'coffee_shops/index'
  get 'coffee_shops/show'
  get 'coffee_shops/new'
  get 'coffee_shops/create'
  get 'coffee_shops/edit'
  get 'coffee_shops/update'
  get 'coffee_shops/destroy'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }
  
  devise_scope :user do
    root :to => "web#index"
    get "signup", :to => "users/registrations#new"
    get "verify", :to => "users/registrations#verify"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end
  
  resources :products
  
end
