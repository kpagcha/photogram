Rails.application.routes.draw do

  root 'posts#index'

  get '/posts/explore', to: 'posts#explore', as: 'explore_posts'
  resources :posts do
    get '/comments/page/:comment_page', to: 'comments#index', as: 'more_comments'
  	resources :comments
  	member do
  		put 'like', to: 'posts#like', as: 'like'
  		put 'unlike', to: 'posts#unlike', as: 'unlike'
  	end
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  get ':user_name', to: 'users#index', as: 'user_posts'
  put ':user_name/follow', to: 'users#follow', as: 'follow_user'
  put ':user_name/unfollow', to: 'users#unfollow', as: 'unfollow_user'
  get ':user_name/followers', to: 'users#followers', as: 'user_followers'
  get ':user_name/following', to: 'users#following', as: 'user_following'
end