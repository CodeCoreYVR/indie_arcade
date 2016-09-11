Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create]
  resources :games do
    resources :reviews, only: [:show]
  end

  resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection
  end

  get "/contact" => "home#contact"
  post "/contact" => "home#create", as: :message_home
  resources :home, only: [:index]

  get '/about' => 'home#about', as: :about
  get '/faq' => 'home#faq', as: :faq

  root 'home#index'
end
