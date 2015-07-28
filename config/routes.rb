Rails.application.routes.draw do

  root 'posts#index'

  resources :posts do
  	resources :comments
  end

  devise_for :users, controllers: { registrations: 'registrations' }
end