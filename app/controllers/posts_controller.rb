class PostsController < ApplicationController
	before_action :load_post, only: [:show, :edit, :update, :destroy]


	def index
		@user = User.find(session[:user_id])
		@posts = Post.all
	end
	def welcome
		@user = User.find(session[:user_id])
		@posts = Post.order("created_at desc").limit(4).offset(1)
		@signed_in_user = session[:user_id]
	end
	def posts
		@user = User.find(session[:user_id]) unless session[:user_id] == nil
    	redirect_to login_path, notice: "You're not logged in" unless @user 
    	@signed_in_user = session[:user_id]
	end
	def dashboard

	end

	
	def new	
		@post = Post.new
		@user = User.find(session[:user_id])
	end
	def create 
		@user = User.find(session[:user_id])        
    	@post = Post.new(post_params)

    	@post.user_id = @signed_in_user

		if 	@post.save 
		    redirect_to dashboard_path 
		else
		    render 'new'
		end
	end
	def show
		@user = User.find(session[:user_id])
		
		@signed_in_user = session[:user_id]
	end
	def edit
		@user = User.find(session[:user_id])
	end	

	def update
		if @post.update(post_params)
			redirect_to @post, notice: "Your post has been updated!"
		end
	end
	def destroy
		@user = User.find(session[:user_id])
		@post.user_id = @signed_in_user
		
		@post.destroy

		redirect_to posts_path
	end

	private

	def load_post
		@post = Post.find(params[:id])
	end
	def post_params
		params.require(:post).permit(:body)
	end
end
