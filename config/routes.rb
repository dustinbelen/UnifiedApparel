Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

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

  root to: "products#index"
end
