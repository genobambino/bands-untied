class SessionsController < ApplicationController
  before_action :checked_logged_in, only: :login 
  def login

  end

  def create
  	user = User.find_by(name: params[:name])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id 
  		redirect_to dashboard_path
  	else 
  		redirect_to login_url, notice: "Invalid User or Password Combination"
  	end

  end

  def destroy
  	if session[:user_id]
  		session[:user_id] = nil
  		redirect_to login_url

  	end

  end
  private 

  def checked_logged_in 
    if session[:user_id]
      redirect_to dashboard_path, notice: "You are already logged in"

    end
    
  end
end
