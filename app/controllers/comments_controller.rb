class CommentsController < ApplicationController
	before_action :find_post

	def index
		if params[:page].blank?
			@comments = @post.comments.order("created_at DESC")
		else
			@comments = @post.comments.order("created_at DESC").take limit
		end
		respond_to do |format|
			format.html { redirect_to root_path }
			format.js
		end
	end

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			respond_to do |format|
				format.html { redirect_to root_path }
				format.js
			end
		else
			flash[:alert] = "Check the comment form, something went horribly wrong"
			render root_path
		end
	end

	def destroy
		@comment = Comment.find(params[:id])

		if @comment.user == current_user
			@comment.destroy
			respond_to do |format|
				format.html { redirect_to root_path }
				format.js
			end
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def find_post
		@post = Post.find(params[:post_id])
	end
end
