Rails.application.routes.draw do
  resources :sales
  root 'welcome#index'

  resources :purchases do
  	resources :exports
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
