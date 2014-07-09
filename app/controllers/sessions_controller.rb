class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(user_email: params[:session][:user_email].downcase)
		if user.user_status == 1
			redirect_to (user_shutdown_path) and return
		end
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = params[:session][:user_email] #'Invalid email/password combination'
      		render 'new'
		end
	end

	def destroy
    sign_out
    redirect_to root_path
  end
end
