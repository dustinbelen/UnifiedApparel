Rails.application.routes.draw do
  devise_for :users
  resources :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html\

  resources :pages do
    collection do
      get "all_pages"
      get "show"
    end
  end

  resources :categories do
    collection do
      get "index"
      get "show"
    end
  end

  resources :products do
    collection do
      get "all_products"
      get "show"
      get "cart"
      get "checkout"
      get "payment"
    end
  end

  get "search", to: "categories#search", as: "search" # search_path
  get "filter", to: "products#filter", as: "filter" # search_path

  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "product/remove_from_cart/:id&:p_color_id&:p_size_id&:quantity", to: "products#remove_from_cart", as: "remove_from_cart"
  post "product/update_from_cart/:id&:p_color_id&:p_size_id&:quantity", to: "products#update_from_cart", as: "update_from_cart"
  post "product/process_customer_info", to: "products#process_customer_info", as: "process_customer_info"
  post "product/process_payment", to: "products#process_payment", as: "process_payment"

  root to: "products#index"
end
