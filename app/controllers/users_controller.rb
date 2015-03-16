class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :signed_in_after_register, only: :create 

  def index
    @users = User.all
    @user = User.find(session[:user_id])
    @user = User.search(params[:search])
  end

  def dashboard 
    @user = User.find(session[:user_id]) unless session[:user_id] == ""
    redirect_to login_path, notice: "You're not logged in" unless @user 
    @posts = @user.posts.order("created_at DESC").limit(3)
    @comment = Comment.new 
    @post = Post.new 
  end 

  def newsfeed
    @user = User.find(session[:user_id]) unless session[:user_id] == nil
    redirect_to login_path, notice: "You're not logged in" unless @user 
    @posts = @user.posts.order("created_at DESC").limit(3)
  end

  def nav
    @user = User.find(session[:user_id])
  end
  def posts
    @user = User.find(session[:user_id])
    @posts = @user.posts
  end


  def destroy
    @user = User.find(session[:user_id]) unless session[:user_id] == ""
    redirect_to login_path, notice: "You're not logged in" unless @user 
  end

  def welcome
    @user = User.find(session[:user_id]) unless session[:user_id] == ""
    redirect_to login_path, notice: "You're not logged in" unless @user 
  end

  def show
    @user = User.find(session[:user_id]) unless session[:user_id] == ""
    redirect_to login_path, notice: "You're not logged in" unless @user 
    @posts = @user.posts.order("created_at DESC").limit(3)
    @comment = Comment.new 
    @post = Post.new 
  end

  # GET /users/new
  def new
    @post = Post.new(params[:post_id])
    @user = User.new
  end

  # GET /users/1/edit
  def edit

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to dashboard_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to dashboard_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    def signed_in_after_register 
      session[:user_id] = @user.id 
    end
      
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :bio, :name, :password, :password_confirmation, :email, :age, :profile_picture, :post, :body)
    end
end
