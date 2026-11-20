Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post "add/:product_id", to: "carts#add", as: :add_to
    patch "update/:product_id", to: "carts#update", as: :update_item
    delete "remove/:product_id", to: "carts#remove", as: :remove_item
  end

  resources :orders, only: [:new, :create, :show]
  get "/about", to: "pages#show", defaults: { slug: "about" }, as: :about
  get "/contact", to: "pages#show", defaults: { slug: "contact" }, as: :contact
end