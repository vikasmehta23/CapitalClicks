Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'
  get "sales/buyergst" => "sales#buyergst", :as => "buyergst_sale"
	get "sales/downloadsummary" => "sales#downloadsummary", :as => "downloadsummary_sale"

  resources :sales
  root 'welcome#index'

get "purchases/download/:id" => "purchases#download", :as => "download_purchase"
get "sales/download/:id" => "sales#download", :as => "download_sale"

get "purchases/print" => "purchases#print", :as => "print_purchase"
get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"
root :to => "users#new"
resources :users
resources :sessions

resources :purchases do
  	resources :exports
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
