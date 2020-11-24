
Rails.application.routes.draw do
  root 'products#index'
  put 'line_items/:id/add', to: 'line_items#add_quantity', as: 'add_quantity'
  put 'line_items/:id/remove', to: 'line_items#remove_quantity', as: 'remove_quantity'
  resources :line_items
  resources :carts
  devise_for :users
  resources :products
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
