class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user

	def index
		@posts = @user.posts
	end

	private

	def find_user
		@user = User.find_by_user_name(params[:user_name])
	end
end
