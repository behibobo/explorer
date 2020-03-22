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
    get 'dashboard/state/:id', to: 'dashboard#state_users'
    get 'states', to: 'dashboard#state'
    get 'cities', to: 'dashboard#city'
    post 'upload', to: "uploader#upload"
    resources :users
    resources :items
    resources :shops
  end

end
