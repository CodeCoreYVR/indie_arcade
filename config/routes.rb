Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :games do
    resources :reviews, only: [:show]
  end

  resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection
  end

  get "/contact" => "home#contact"
  post "/contact" => "home#create", as: :message_home
  root 'home#index'
end
