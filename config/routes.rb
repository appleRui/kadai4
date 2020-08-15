Rails.application.routes.draw do
  devise_for :users
  root to:'home#top'
  get 'home/about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :new, :create, :show ,:edit, :update,  :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
