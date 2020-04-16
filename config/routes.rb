Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :cooking_repertoires, only:[:new, :create]
  root to: 'cooking_repertoires#new'
end
