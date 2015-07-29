Rails.application.routes.draw do

  root 'posts#index'

  resources :posts do
  	resources :comments
  	member do
  		put 'like', to: 'posts#like', as: 'like'
  		put 'unlike', to: 'posts#unlike', as: 'unlike'
  	end
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  get ':user_name', to: 'users#index', as: 'user_posts'
end