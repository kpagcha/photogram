class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user, only: [ :index, :followers, :following ]
	before_action :set_other_user, only: [ :follow, :unfollow ]

	def index
		@posts = @user.posts.order("created_at DESC")
	end

	def follow
		current_user.follow @other_user
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
	end

	def unfollow
		current_user.stop_following @other_user
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
	end

	def followers
		@users = @user.followers
	end

	def following
		@users = @user.all_following
	end

	private

	def find_user
		@user = User.find_by_user_name(params[:user_name])
	end

	def set_other_user
		@other_user = User.find_by_user_name(params[:user_name])
	end
end
