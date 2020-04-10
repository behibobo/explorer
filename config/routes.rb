Rails.application.routes.draw do

  namespace :app do
    post 'auth/login', to: 'auth#login'
    post 'auth/activate', to: 'auth#activate'
    get 'user', to: 'user#index'
    get 'items', to: 'items#index'
    get 'gift_items', to: 'items#gift_items'
    get 'treasures', to: 'treasures#index'
    post 'scan_item', to: 'items#scan_item'
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
    get 'shop_items', to: 'items#shop_items'
    get 'none_shop_items', to: 'items#none_shop_items'
    resources :users
    resources :items
    resources :gifts
    resources :treasures
    resources :shops do
      resources :items
    end
    get 'find_shops', to: 'shops#find_shops'

  end

end
