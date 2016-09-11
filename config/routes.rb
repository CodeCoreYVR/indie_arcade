Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :games do
    resources :reviews, only: [:show]
  end

  resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection
  end

  resources :home, only: [:index]

  get '/about' => 'home#about', as: :about

  root 'home#index'
end
