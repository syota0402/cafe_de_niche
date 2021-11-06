Rails.application.routes.draw do
  get "dashboard", :to => "dashboard#index"
  
  resources :coffee_shops do
    member do 
      get :favorite
    end
    get :search, on: :collection
    resources :reviews, only: [:create]
  end
  
  resources :reviews, only: [:destroy]
  
  namespace :dashboard do
    resources :users, only: [:index, :destroy]
    resources :coffee_shops, except: [:show]
    resources :search_categories, except: [:new]
    resources :prefectures, except: [:new]
    resources :municipalities, except: [:new]
  end
  
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
  
  resources :users, only: [:edit, :update, :show] do
    collection do
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      put "mypage", :to => "users#update"
      get "mypage/edit_password", :to => "users#edit_password"
      put "mypage/password", :to => "users#update_password"
      delete "mypage/delete", :to => "users#destroy"
      get "favorite", :to => "users#favorite"
      get "following", :to => "users#following"
      get "follower", :to => "users#follower" 
    end
    member do 
      get :follow
    end
  end
  
end
