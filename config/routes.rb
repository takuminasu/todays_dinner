Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cooking_repertoires, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :cooking_repertoire_tags, only: [:create]
  resources :tags, only: [:index]
  resources :menus, only: [:index, :new, :create]
  root to: 'menus#index'
end
