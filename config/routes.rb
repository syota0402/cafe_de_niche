Rails.application.routes.draw do
  get 'users/edit'
  get 'users/update'
  get 'users/mypage'
  get "dashboard", :to => "dashboard#index"
  
  resources :coffee_shops do
    get :search, on: :collection
  end
  
  namespace :dashboard do
    resources :coffee_shops, except: [:show]
    resources :search_categories, except: [:new]
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
  
  resources :users, only: [:edit, :update] do
    collection do
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      put "mypage", :to => "users#update"
    end
  end
  
end
