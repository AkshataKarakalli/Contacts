Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :friends do
    collection { post :import }
  end
  get 'home/index'
  get 'search' => 'friends#search'
  #root 'home#index'
  root 'friends#index'
  get 'exams' => 'exams#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
