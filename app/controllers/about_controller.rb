class AboutController < ApplicationController
	def about
		@user = User.find(session[:user_id])
	end

end
