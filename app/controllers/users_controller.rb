class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user, only: [ :index ]
	before_action :set_user_to_follow, only: [ :follow, :unfollow ]

	def index
		@posts = @user.posts
	end

	def follow
		@user_to_follow.followers << current_user
		redirect_to :back
	end

	def unfollow
		@user_to_follow.followers.delete current_user
		redirect_to :back
	end

	private

	def find_user
		@user = User.find_by_user_name(params[:user_name])
	end

	def set_user_to_follow
		@user_to_follow = User.find_by_user_name(params[:user_name])
	end
end
