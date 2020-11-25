Rails.application.routes.draw do
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
    end
  end

  get "search", to: "categories#search", as: "search" # search_path

  root to: "products#index"
end
