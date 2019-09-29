Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:new, :create]
  end
  
  devise_for :users
  root to: 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
