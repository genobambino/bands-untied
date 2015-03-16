class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_signed_in_user

  def set_signed_in_user

  	if session[:user_id].present?
  		@signed_in_user = session[:user_id]
  	end
  end
end
