Rails.application.routes.draw do
  resources :graphs

  root to: 'graphs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
