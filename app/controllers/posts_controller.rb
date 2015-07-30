class PostsController < ApplicationController
	before_action :find_post, only: [ :show, :edit, :update, :destroy, :like, :unlike, :load_more_comments ]
	before_action :owned_post, only: [ :edit, :update, :destroy ]
	before_action :authenticate_user!

	def index
		@posts = Post.where(user_id: current_user.all_following.collect(&:id).push(current_user.id)).order("created_at DESC")
	end

	def explore
		@q = Post.ransack(params[:q])
		@posts = @q ? @q.result(distinct: true) : Post.all
		@posts = @posts.order("created_at DESC")
	end

	def show
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build post_params

		if @post.save
			flash[:success] = "Your post has been created!"
			redirect_to root_path
		else
			flash.now[:alert] = "Your new post couldn't be created! Please check the form"
			render 'new'
		end
	end

	def edit
	end

	def update
		if @post.update post_params
			flash[:success] = "Post updated"
			redirect_to post_path(@post)
		else
			flash.now[:alert] = "Update failed. Please check the form"
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		flash[:notice] = "Post deleted"
		redirect_to posts_path
	end

	def like
		@post.liked_by current_user
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
	end

	def unlike
		@post.unliked_by current_user
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
	end

	private

	def post_params
		params.require(:post).permit(:image, :caption)
	end

	def find_post
		@post = Post.find(params[:id])
	end

	def owned_post
		unless current_user == @post.user
			flash[:alert] = "That post doesn't belong to you!"
			redirect_to root_path
		end
	end
end
