Rails.application.routes.draw do
  resources :items
  resources :shops
  namespace :app do
    post 'auth/login', to: 'auth#login'
    post 'auth/signup', to: 'auth#signup'
    post 'auth/activate', to: 'auth#activate'
    post 'auth/setpassword', to: 'auth#set_password'
  end

  namespace :api do
    post 'auth/login', to: 'auth#login'
    get 'dashboard', to: 'dashboard#index'
    get 'states', to: 'dashboard#state'
    get 'cities', to: 'dashboard#city'
    resources :users
  end

end
