class CommentsController < ApplicationController
	def create 
	   @post = Post.find(params[:post_id])
	   @comment = Comment.new(body: params[:body], post_id: params[:post_id])
	   @comment.save
	   redirect_to root_path
 	end
	def destroy
		@user = User.find(session[:user_id])
		@posts = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to post_path(@post)
	end
	private
	def comment_params
	  params.require(:comments).permit(:body, :post_id)
	end
end
