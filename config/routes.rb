Rails.application.routes.draw do
  resources :gifts
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
    post 'assign_gift', to: 'items#assign_gift'
    post 'remove_gift', to: 'items#remove_gift'
    resources :users
    resources :items
    resources :shops do
      resources :items
    end
  end

end
