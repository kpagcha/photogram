Rails.application.routes.draw do
  get 'comments/create'

  get 'comments/crate'

  root 'posts#index'

  resources :posts do
  	resources :comments
  end

  devise_for :users, controllers: { registrations: 'registrations' }
end